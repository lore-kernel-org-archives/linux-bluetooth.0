Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJauZSboT+PvdwQ7EGwLMnwDE3ghGjRioBppCfyemsD2w@mail.gmail.com>
References: <CAHY_EhVGVeoE+Ljw_rm+k6LnYC0=ySDsn3qYay3gJ_vM8u7WXw@mail.gmail.com>
 <CABBYNZJauZSboT+PvdwQ7EGwLMnwDE3ghGjRioBppCfyemsD2w@mail.gmail.com>
From: Jason Gauthier <jagauthier@gmail.com>
Date: Mon, 31 Oct 2016 15:57:16 -0400
Message-ID: <CAHY_EhUKMAFcjBQAVmSH7XCXFKxZcU_AFVs76BU2v5xPHZ=stQ@mail.gmail.com>
Subject: Re: obexd MAP/MNS
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 28, 2016 at 4:55 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jason,
>
> On Fri, Oct 28, 2016 at 7:09 AM, Jason Gauthier <jagauthier@gmail.com> wrote:
>> Hello,
>>
>>    In Python, I've been successful interfacing with PBAP, and recently
>> MAP.  Ultimately, though, my goal is to receive new message
>> notifications using MNS part of MAP.
>>
>> I've read the Bluetooth document on MAP (section 6), and I've seen a
>> few requests around, but I am not sure how to implement this.
>>
>> Does anyone have any python examples, or documentation, on how this is
>> implemented?
>
> Check obexctl under tools, when a notification arrive it will create
> an object implementing interface org.bluez.obex.Message1 which you can
> subscribe with InterfacesAdded signal from ObjectManager.
>

Luiz,

 Thanks.  I've never used obexctl before. Thanks for pointing it out
to me.  I've been experimenting with this a bit.  Maybe I'm on the
wrong track.  It seems to me that  org.bluez.obex.Message1 is an
interface for a specific message. These messages do not exist until
after I do a .Get() function or one is received to the device.  Once
they do exist the only signal that exists on the interface appears to
be PropertiesChanged.

I do see new messages arrive within obexctl:
[NEW] Message /org/bluez/obex/client/session10/message288230376151721061

Which would be the interface you are mentioning.  But I can't seem to
capture this message within my existing code.
I've attached to the session ( /org/bluez/obex/client/session10/), and
I am using the one and only signal at this level:
signal void org.freedesktop.DBus.Properties.PropertiesChanged(QString
interface, QVariantMap changed_properties, QStringList
invalidated_properties)

BUS_NAME='org.bluez.obex'
SESSION_INTERFACE = 'org.bluez.obex.Session1'
MESSAGE_ACCESS_INTERFACE = 'org.bluez.obex.MessageAccess1'

       bus = dbus.SessionBus()
       obj = bus.get_object(BUS_NAME, session_path)
       self.session = dbus.Interface(obj, SESSION_INTERFACE)
       self.map = dbus.Interface(obj, MESSAGE_ACCESS_INTERFACE)

        bus.add_signal_receiver(self.properties_changed,
            dbus_interface="org.freedesktop.DBus.Properties",
            signal_name="PropertiesChanged",
            path_keyword="path")

But when the new message comes the signal is not activated.   This is
the only way I can think of to achieve access to the new message.

Jason
