Return-Path: <cyrus@holtmann.org>
In-Reply-To: <BANLkTim72aKHWTvQOjfbFwyxP1j4v2MFWg@mail.gmail.com>
References: <OF2953F661.C5E1B3A9-ON4825786C.000D1F6C-4825786C.000D35E6@cn.ibm.com> <BANLkTim72aKHWTvQOjfbFwyxP1j4v2MFWg@mail.gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Subject: Re: HDP, can't read data from fd which Acquire from HealthChannel
Message-ID: <OF863AA7F4.5F9948F5-ON4825786C.0028E48A-4825786C.002969DE@cn.ibm.com>
From: Yi Hui Fan <yihuifan@cn.ibm.com>
Date: Fri, 8 Apr 2011 15:32:04 +0800
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jose,


> Jose Antonio Santos Cadenas <santoscadenas@gmail.com> 
> Sent by: linux-bluetooth-owner@vger.kernel.org
> 
> 2011-04-08 15:04
> 
> To
> 
> Yi Hui Fan/China/IBM@IBMCN
> 
> cc
> 
> linux-bluetooth@vger.kernel.org
> 
> Subject
> 
> Re: HDP, can't read data from fd which Acquire from HealthChannel
> 
> Hi,
> 
> 2011/4/8 Yi Hui Fan <yihuifan@cn.ibm.com>:
> > Dears
> >
> > I'd like to build a demo for HDP sink. I try to use the DBUS API 
provided
> > by Bluez. But there is a problem with unix fd to receive data.
> >
> > I can get fd by calling HealthChannel.Acquire method.  following is 
the
> > code I write to read data according the sock I got.
> >
> >        fd_set rfds;
> >        struct timeval tv;
> >        int rv;
> >        char buff[1024];
> >
> >        FD_ZERO(&rfds);
> >        FD_SET(sock, &rfds);
> >        tv.tv_sec = 10;
> >        tv.tv_usec = 500;
> >
> >        rv = select(sock+1, &rfds, NULL, NULL, &tv);
> >
> >        rv = recv(sock, buff, 1024, 0);
> >
> > rv is always return 0 when I call select method. I can't get anything.
> >
> > Any problem with these codes?
> 
> It seems that you don't have a valid file descriptor. How are you
> getting the file descriptor? Are you using Dbus 1.4?
> 

Yes, I am using Dbus 1.4.
I got the file descriptor by calling Acquire method of HealthChannel. Here 
is the code I wrote to get file descriptor.

        DBusConnection* conn;
        DBusError err;
        DBusMessage* msg;
        DBusMessage* reply;
        DBusMessageIter *iter;
 
        int sock;

        dbus_error_init(&err);
        printf("start get dbus connection\n");
        conn = dbus_bus_get(DBUS_BUS_SYSTEM, &err);
        if (dbus_error_is_set(&err)) {
                fprintf(stderr, "Connection Error (%s)\n", err.message);
                dbus_error_free(&err);
                return -1;
        }

        if((msg = dbus_message_new_method_call("org.bluez", channel_path, 
"org.bluez.HealthChannel",
                        "Acquire"))==NULL)
        {
                dbus_message_unref(msg);
                printf("initial msg failed!");
                return -1;
        }

        reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, 
&err);

        dbus_message_get_args(reply, &err, DBUS_TYPE_UNIX_FD, &sock, 
DBUS_TYPE_INVALID);
 
        dbus_message_unref(msg);
        dbus_message_unref(reply);
        dbus_connection_unref(conn);

        return sock;

> 
> >
> > Thanks &
> > Best regards,
> 
> Regards
> 
> Jose.
> 
> >
> > Yihui,Fan
> --
> To unsubscribe from this list: send the line "unsubscribe 
linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

