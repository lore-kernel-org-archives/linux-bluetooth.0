Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+YbBdhVNqvxokOs14Y2fpphG3s2pHWvWUaRiizZCYVaeCQ@mail.gmail.com>
References: <1397231937-29475-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<CAN_7+YbBdhVNqvxokOs14Y2fpphG3s2pHWvWUaRiizZCYVaeCQ@mail.gmail.com>
Date: Mon, 14 Apr 2014 14:37:06 +0200
Message-ID: <CAMv5Gbf=mB2LiM2cB+gcSZcyLEXWitXjeuzN8r-5d-rLcR0=5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/gatt: Add support for uuid filter in search services
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 12 April 2014 20:46, Lukasz Rymanowski <lukasz.rymanowski@gmail.com> wrote:
>
> Hi Grzegorz,
>
> On Fri, Apr 11, 2014 at 5:58 PM, Grzegorz Kolodziejczyk
> <grzegorz.kolodziejczyk@tieto.com> wrote:
> > This adds support for filtering by uuid in searched services.
> > ---
> >  android/gatt.c | 168 ++++++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 114 insertions(+), 54 deletions(-)
> >
> > diff --git a/android/gatt.c b/android/gatt.c
> > index 243e02f..d8c63bf 100644
> > --- a/android/gatt.c
> > +++ b/android/gatt.c
> > @@ -314,6 +314,14 @@ static bool match_char_by_higher_inst_id(const void *data,
> >         return inst_id < ch->id.instance;
> >  }
> >
> > +static bool match_srvc_by_bt_uuid(const void *data, const void *user_data)
> > +{
> > +       const bt_uuid_t *exp_uuid = user_data;
> > +       const struct service *service = data;
> > +
> > +       return !bt_uuid_cmp(exp_uuid, &service->id.uuid);
> > +}
> > +
> >  static bool match_descr_by_element_id(const void *data, const void *user_data)
> >  {
> >         const struct element_id *exp_id = user_data;
> > @@ -534,22 +542,6 @@ static void send_client_primary_notify(void *data, void *user_data)
> >                                         sizeof(ev), &ev);
> >  }
> >
> > -static void send_client_all_primary(int32_t status, struct queue *services,
> > -                                                       int32_t conn_id)
> > -{
> > -       struct hal_ev_gatt_client_search_complete ev;
> > -
> > -       if (!status)
> > -               queue_foreach(services, send_client_primary_notify,
> > -                                                       INT_TO_PTR(conn_id));
> > -
> > -       ev.status = status;
> > -       ev.conn_id = conn_id;
> > -       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> > -                       HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
> > -
> > -}
> > -
> >  static struct service *create_service(uint8_t id, bool primary, char *uuid,
> >                                                                 void *data)
> >  {
> > @@ -597,34 +589,11 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
> >         return s;
> >  }
> >
> > -static void primary_cb(uint8_t status, GSList *services, void *user_data)
> > +static void primary_cb(GSList *services, struct gatt_device *dev)
> >  {
> > -       struct gatt_device *dev = user_data;
> >         GSList *l;
> > -       int32_t gatt_status;
> >         uint8_t instance_id;
> >
> > -       DBG("Status %d", status);
> > -
> > -       if (status) {
> > -               error("gatt: Discover all primary services failed: %s",
> > -                                                       att_ecode2str(status));
> > -               gatt_status = GATT_FAILURE;
> > -               goto done;
> > -       }
> > -
> > -       if (!services) {
> > -               info("gatt: No primary services found");
> > -               gatt_status = GATT_SUCCESS;
> > -               goto done;
> > -       }
> > -
> > -       if (!queue_isempty(dev->services)) {
> > -               info("gatt: Services already cached");
> > -               gatt_status = GATT_SUCCESS;
> > -               goto done;
> > -       }
> > -
> >         /* There might be multiply services with same uuid. Therefore make sure
> >          * each primary service one has unique instance_id
> >          */
> > @@ -647,11 +616,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
> >                 DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
> >                         prim->range.start, prim->range.end, prim->uuid);
> >         }
> > -
> > -       gatt_status = GATT_SUCCESS;
> > -
> > -done:
> > -       send_client_all_primary(gatt_status, dev->services, dev->conn_id);
> >  }
> >
> >  static void connection_cleanup(struct gatt_device *device)
> > @@ -1240,11 +1204,77 @@ done:
> >                                                                         status);
> >  }
> >
> > +struct discover_srvc_data {
> > +       bt_uuid_t uuid;
> > +       struct gatt_device *dev;
> > +       bool number;
> > +};
> > +
> > +static void send_client_search_complete_notify(int32_t status, int32_t conn_id)
> > +{
> > +       struct hal_ev_gatt_client_search_complete ev;
> > +
> > +       ev.status = status;
> > +       ev.conn_id = conn_id;
> > +       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> > +                       HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
> > +}
> > +
> > +static void discover_srvc_cb(uint8_t status, GSList *services, void *user_data)
> > +{
> > +       struct discover_srvc_data *cb_data = user_data;
> > +       struct service *s;
> > +       int32_t gatt_status;
> > +
> > +       DBG("Status %d", status);
> > +
> > +       if (status) {
> > +               error("gatt: Discover all primary services failed: %s",
> > +                                                       att_ecode2str(status));
> > +               gatt_status = GATT_FAILURE;
> > +               goto reply;
> > +       }
> > +
> > +       if (!services) {
> > +               info("gatt: No primary services found");
> > +               gatt_status = GATT_SUCCESS;
> > +               goto reply;
> > +       }
> > +
> > +       /* Caching primary and included services from remote */
> > +       primary_cb(services, cb_data->dev);
> > +
> > +       /* Send filtered service by uuid */
> > +       if (cb_data->number) {
> > +               s = queue_find(cb_data->dev->services, match_srvc_by_bt_uuid,
> > +                                                               &cb_data->uuid);
> > +               if (s)
> > +                       send_client_primary_notify(s,
> > +                                       INT_TO_PTR(cb_data->dev->conn_id));
> > +               else
> > +                       error("gatt: Service with given UUID not found");
> > +       } else {
> > +               /* Send all found services */
> > +               queue_foreach(cb_data->dev->services,
> > +                                       send_client_primary_notify,
> > +                                       INT_TO_PTR(cb_data->dev->conn_id));
> > +       }
> > +
> > +       gatt_status = GATT_SUCCESS;
> > +
> > +reply:
> > +       send_client_search_complete_notify(gatt_status, cb_data->dev->conn_id);
> > +       free(cb_data);
> > +}
> > +
> >  static void handle_client_search_service(const void *buf, uint16_t len)
> >  {
> >         const struct hal_cmd_gatt_client_search_service *cmd = buf;
> >         struct gatt_device *dev;
> >         uint8_t status;
> > +       struct service *s;
> > +       bt_uuid_t uuid;
> > +       bool number;
> >
> >         DBG("");
> >
> > @@ -1255,26 +1285,56 @@ static void handle_client_search_service(const void *buf, uint16_t len)
> >                 goto reply;
> >         }
> >
> > -       /*TODO:  Handle filter uuid */
> > +       number = cmd->number;
> > +
> > +       if (number)
> > +               android2uuid(cmd->filter_uuid, &uuid);
> > +
> > +       if (queue_isempty(dev->services)) {
> > +               struct discover_srvc_data *cb_data =
> > +                                       new0(struct discover_srvc_data, 1);
> > +
> > +               if (!cb_data) {
> > +                       error("gatt: Cannot allocate cb data");
> > +                       status = HAL_STATUS_FAILED;
> > +                       goto reply;
> > +               }
> > +
> > +               cb_data->dev = dev;
> > +               cb_data->number = number;
> > +               if (number)
> > +                       memcpy(&cb_data->uuid, &uuid, sizeof(cb_data->uuid));
> > +
> > +               if (!gatt_discover_primary(dev->attrib, NULL, discover_srvc_cb,
> > +                                                               cb_data)) {
>
> Actually I did not found place where Android would use this API with
> filter_uuid different then null.
> But I agree we could add this support here for testing purpose but in
> some different way.
Yes there are defined test cases in PTS for filtering uuid.
>
> What you are doing now is search of all primary services and then try
> to find the filtered one.
> What I would do here is actually search primary by value you got in filter_uuid.
> It might be useful for example in PTS testing.
> Of course in this case you need to improve a bit a caching part so
> there is no double entries when  somebody will do search for all
> primary services
I agree that we have to handle partial caching. It will be implemented
by additional variable that will determine what type of caching is
already done (if partial or full service search was performed). In
case of pre searched and cached list of services, service will be
searched on cached list, so there will not be any problem with
caching.
>
> > +                       free(cb_data);
> > +                       status = HAL_STATUS_FAILED;
> > +                       goto reply;
> > +               }
> >
> > -       /* Use cache if possible */
> > -       if (!queue_isempty(dev->services)) {
> >                 status = HAL_STATUS_SUCCESS;
> > -               send_client_all_primary(GATT_SUCCESS, dev->services,
> > -                                                               dev->conn_id);
> >                 goto reply;
> >         }
> >
> > -       if (!gatt_discover_primary(dev->attrib, NULL, primary_cb, dev)) {
> > -               status = HAL_STATUS_FAILED;
> > -               goto reply;
> > +       if (number) {
> > +               s = queue_find(dev->services, match_srvc_by_bt_uuid, &uuid);
> > +
> > +               if (s)
> > +                       send_client_primary_notify(s, INT_TO_PTR(dev->conn_id));
> > +               else
> > +                       error("gatt: Service with given UUID not found");
> > +       } else {
> > +               queue_foreach(dev->services, send_client_primary_notify,
> > +                                               INT_TO_PTR(dev->conn_id));
> >         }
> >
> > +       send_client_search_complete_notify(GATT_SUCCESS, dev->conn_id);
> > +
> >         status = HAL_STATUS_SUCCESS;
> >
> >  reply:
> >         ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> > -                       HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
> > +                               HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
> >  }
> >
> >  static void send_client_incl_service_notify(const struct service *prim,
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> BR
> Lukasz
Best regards,
Grzegorz Kołodziejczyk
