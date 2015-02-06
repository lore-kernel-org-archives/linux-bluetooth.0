Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1423207617-22174-1-git-send-email-bharat.panda@samsung.com>
 <CABBYNZJ_ih0nijN4+bxx3xmc9+x-SpJG-ZzLGEaYwa4=b69JyQ@mail.gmail.com>
In-reply-to: <CABBYNZJ_ih0nijN4+bxx3xmc9+x-SpJG-ZzLGEaYwa4=b69JyQ@mail.gmail.com>
Subject: RE: [PATCH ] shared/gatt: Get primary services by handle
Date: Fri, 06 Feb 2015 16:58:31 +0530
Message-id: <010301d04200$1ef06a90$5cd13fb0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Friday, February 06, 2015 4:41 PM
> To: Bharat Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH ] shared/gatt: Get primary services by handle
> 
> Hi Bharat,
> 
> On Fri, Feb 6, 2015 at 9:26 AM, Bharat Panda <bharat.panda@samsung.com>
> wrote:
> > Adds support for retrieving primary services from gatt-db by handle.
> 
> I need more input why we need this, what is the use case, etc. Also there is a
> handle range already, perhaps you want the range to be used locally within
> the service range?
In btgatt-client tool, with command "services" with option "-a" and given the handle value of a particular service, it was returning all the services stored gatt-db, rather the intention was only to get the particular service with the given service handle. This patch will do the same.
All services with given handle range can be retrieved with current implementation, not for single service with a given handle. 
> 
> > ---
> >  src/shared/gatt-db.c  | 38 +++++++++++++++++++++++++++++++++++---
> >  src/shared/gatt-db.h  |  6 ++++++
> >  tools/btgatt-client.c |  8 ++++----
> >  3 files changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c index
> > f72d58e..f22111b 100644
> > --- a/src/shared/gatt-db.c
> > +++ b/src/shared/gatt-db.c
> > @@ -1036,15 +1036,23 @@ void gatt_db_foreach_service(struct gatt_db
> *db, const bt_uuid_t *uuid,
> >                                                 gatt_db_attribute_cb_t func,
> >                                                 void *user_data)  {
> > -       gatt_db_foreach_service_in_range(db, uuid, func, user_data, 0x0001,
> > -                                                                       0xffff);
> > +       gatt_db_foreach_service_in_range(db, uuid, 0x0000, func, user_data,
> > +                                       0x0001, 0xffff); }
> > +
> > +void gatt_db_foreach_service_handle(struct gatt_db *db, uint16_t
> handle,
> > +                                               gatt_db_attribute_cb_t func,
> > +                                               void *user_data) {
> > +       gatt_db_foreach_service_in_range(db, NULL, handle, func,
> user_data,
> > +                                       0x0001, 0xffff);
> >  }
> >
> >  struct foreach_data {
> >         gatt_db_attribute_cb_t func;
> >         const bt_uuid_t *uuid;
> >         void *user_data;
> > -       uint16_t start, end;
> > +       uint16_t start, end, handle;
> >  };
> >
> >  static void foreach_service_in_range(void *data, void *user_data) @@
> > -1053,6 +1061,7 @@ static void foreach_service_in_range(void *data, void
> *user_data)
> >         struct foreach_data *foreach_data = user_data;
> >         uint16_t svc_start;
> >         bt_uuid_t uuid;
> > +       uint16_t handle;
> >
> >         svc_start = get_handle_at_index(service, 0);
> >
> > @@ -1064,6 +1073,11 @@ static void foreach_service_in_range(void *data,
> void *user_data)
> >                                                                         &uuid);
> >                 if (bt_uuid_cmp(&uuid, foreach_data->uuid))
> >                         return;
> > +       } else if (foreach_data->handle) {
> > +               gatt_db_attribute_get_service_handle(service->attributes[0],
> > +                                                       &handle);
> > +               if (handle != foreach_data->handle)
> > +                       return;
> >         }
> >
> >         foreach_data->func(service->attributes[0],
> > foreach_data->user_data); @@ -1071,6 +1085,7 @@ static void
> > foreach_service_in_range(void *data, void *user_data)
> >
> >  void gatt_db_foreach_service_in_range(struct gatt_db *db,
> >                                                 const bt_uuid_t *uuid,
> > +                                               uint16_t handle,
> >                                                 gatt_db_attribute_cb_t func,
> >                                                 void *user_data,
> >                                                 uint16_t start_handle,
> > @@ -1086,6 +1101,7 @@ void gatt_db_foreach_service_in_range(struct
> gatt_db *db,
> >         data.user_data = user_data;
> >         data.start = start_handle;
> >         data.end = end_handle;
> > +       data.handle = handle;
> >
> >         queue_foreach(db->services, foreach_service_in_range, &data);
> > } @@ -1273,6 +1289,22 @@ bool
> gatt_db_attribute_get_service_uuid(const
> > struct gatt_db_attribute *attrib,
> >         return false;
> >  }
> >
> > +bool gatt_db_attribute_get_service_handle(
> > +                                       const struct gatt_db_attribute *attrib,
> > +                                       uint16_t *handle) {
> > +       struct gatt_db_service *service;
> > +
> > +       if (!attrib || !handle)
> > +               return false;
> > +
> > +       service = attrib->service;
> > +
> > +       *handle = service->attributes[0]->handle;
> > +
> > +       return true;
> > +}
> > +
> >  bool gatt_db_attribute_get_service_handles(
> >                                         const struct gatt_db_attribute *attrib,
> >                                         uint16_t *start_handle, diff
> > --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h index
> > 37df4d5..4308fbc 100644
> > --- a/src/shared/gatt-db.h
> > +++ b/src/shared/gatt-db.h
> > @@ -122,8 +122,12 @@ void gatt_db_find_information(struct gatt_db *db,
> > uint16_t start_handle,  void gatt_db_foreach_service(struct gatt_db *db,
> const bt_uuid_t *uuid,
> >                                                 gatt_db_attribute_cb_t func,
> >                                                 void *user_data);
> > +void gatt_db_foreach_service_handle(struct gatt_db *db, uint16_t
> handle,
> > +                                               gatt_db_attribute_cb_t func,
> > +                                               void *user_data);
> >  void gatt_db_foreach_service_in_range(struct gatt_db *db,
> >                                                 const bt_uuid_t *uuid,
> > +                                               uint16_t handle,
> >                                                 gatt_db_attribute_cb_t func,
> >                                                 void *user_data,
> >                                                 uint16_t start_handle,
> > @@ -165,6 +169,8 @@ uint16_t gatt_db_attribute_get_handle(const struct
> > gatt_db_attribute *attrib);
> >
> >  bool gatt_db_attribute_get_service_uuid(const struct gatt_db_attribute
> *attrib,
> >                                                         bt_uuid_t
> > *uuid);
> > +bool gatt_db_attribute_get_service_handle(const struct
> gatt_db_attribute *attrib,
> > +                                                       uint16_t
> > +*handle);
> >
> >  bool gatt_db_attribute_get_service_handles(
> >                                         const struct gatt_db_attribute
> > *attrib, diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> > index 8bda89b..801fa7f 100644
> > --- a/tools/btgatt-client.c
> > +++ b/tools/btgatt-client.c
> > @@ -302,8 +302,7 @@ static void print_services_by_handle(struct client
> > *cli, uint16_t handle)  {
> >         printf("\n");
> >
> > -       /* TODO: Filter by handle */
> > -       gatt_db_foreach_service(cli->db, NULL, print_service, cli);
> > +       gatt_db_foreach_service_handle(cli->db, handle, print_service,
> > + cli);
> >  }
> >
> >  static void ready_cb(bool success, uint8_t att_ecode, void
> > *user_data) @@ -330,8 +329,9 @@ static void
> service_changed_cb(uint16_t start_handle, uint16_t end_handle,
> >         printf("\nService Changed handled - start: 0x%04x end: 0x%04x\n",
> >                                                 start_handle,
> > end_handle);
> >
> > -       gatt_db_foreach_service_in_range(cli->db, NULL, print_service, cli,
> > -                                               start_handle, end_handle);
> > +       gatt_db_foreach_service_in_range(cli->db, NULL, 0x0000,
> > +                               print_service, cli,
> > +                               start_handle, end_handle);
> >         print_prompt();
> >  }
> >
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

Regards
-- Bharat

