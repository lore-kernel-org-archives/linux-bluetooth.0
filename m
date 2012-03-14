Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331215032-27695-7-git-send-email-arik@wizery.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
	<1331215032-27695-7-git-send-email-arik@wizery.com>
Date: Wed, 14 Mar 2012 09:09:39 -0400
Message-ID: <CAJdJm_MA24vaSzBeT6YS5-htYMjfszNmULrAtvPQgC=1LQLj-A@mail.gmail.com>
Subject: Re: [PATCH 6/8] proximity: link loss: implement link loss server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Thu, Mar 8, 2012 at 9:57 AM, Arik Nemtsov <arik@wizery.com> wrote:
> +void register_link_loss(struct btd_adapter *adapter, DBusConnection *conn)
> +{
> +       gboolean svc_added;
> +       bt_uuid_t uuid;
> +       struct link_loss_adapter *lladapter;
> +
> +       bt_uuid16_create(&uuid, LINK_LOSS_SVC_UUID);
> +
> +       lladapter = g_new0(struct link_loss_adapter, 1);
> +       lladapter->adapter = adapter;
> +       lladapter->conn = dbus_connection_ref(conn);
> +
> +       link_loss_adapters = g_slist_append(link_loss_adapters, lladapter);
> +
> +       /* Link Loss Service */
> +       svc_added = gatt_service_add(adapter,
> +               GATT_PRIM_SVC_UUID, &uuid,
> +               /* Alert level characteristic */
> +               GATT_OPT_CHR_UUID, ALERT_LEVEL_CHR_UUID,
> +               GATT_OPT_CHR_PROPS,
> +                       ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE,
> +               GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
> +                       link_loss_alert_lvl_read, lladapter,
> +               GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
> +                       link_loss_alert_lvl_write, lladapter,
> +               GATT_OPT_CHR_VALUE_GET_HANDLE,
> +                       &lladapter->alert_lvl_value_handle,
> +               GATT_OPT_INVALID);
> +
> +       if (!svc_added)
> +               goto err;
> +
> +       lladapter->watch = g_dbus_add_signal_watch(lladapter->conn,
> +                               BLUEZ_SERVICE, NULL, DEVICE_INTERFACE,
> +                               "DisconnectRequested", handle_local_disconnect,
> +                               lladapter, NULL);

Does this also work if the device is removed locally with:

* test-device remove ?
* when bluez is shutting down?
* user disables the adapter locally?

Also, listening to a d-bus signal of the process itself looks strange.
Did you try the device_add_disconnect_watch() call instead?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
