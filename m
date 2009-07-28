Return-Path: <cyrus@holtmann.org>
Message-ID: <4A6E5B7F.4000109@dtsp.co.nz>
Date: Tue, 28 Jul 2009 13:59:27 +1200
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Gnome applet failing with current BlueZ?
References: <4A6E3161.7010105@dtsp.co.nz>	 <1248742400.23466.11069.camel@localhost.localdomain>	 <4A6E523E.6000802@dtsp.co.nz> <1248744238.23466.11103.camel@localhost.localdomain>
In-Reply-To: <1248744238.23466.11103.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> On Tue, 2009-07-28 at 13:19 +1200, David Sainty wrote:
>   
>> Bastien Nocera wrote:
>>     
>>> On Tue, 2009-07-28 at 10:59 +1200, David Sainty wrote:
>>>   
>>>       
>>>> Hi all,
>>>>
>>>> Using BlueZ 4.46 and Gnome Bluetooth 2.27.8, the applet icon fails to 
>>>> appear.  If I pull the USB adapter out and in the icon appears, but with 
>>>> a little red cross, and it isn't very functional.
>>>>     
>>>>         
>>> Is bluetoothd running?
>>> <snip>
>>>   
>>>       
>> Yes, and otherwise functional.  For example, I'm sending this reply over 
>> a bluetooth GPRS connection, and at the same time can see the 
>> non-functional bluetooth-applet icon with the little red/white cross.
>>
>> Running bluetoothd in debug mode didn't seem to display any useful 
>> information relating to the applet.
>>     
>
>   
>> Agent registration failed: Rejected send message, 2 matched rules; 
>> type="method_call", sender=":1.12" (uid=1000 pid=1473 
>> comm="bluetooth-applet -d ") interface="org.bluez.Adapter" 
>> member="RegisterAgent" error name="(unset)" requested_reply=0 
>> destination="org.bluez" (uid=0 pid=1100 comm="bluetoothd "))
>>     
>
> Do you have blueman, or the applet from bluez-gnome running?
>   

No and no.

> Looks like D-Bus is refusing the connection, which version of bluez are
> you using?
>
>   

BlueZ 4.46

If I run "dbus-monitor --system" I get this (and only this) immediately 
every time I start bluetooth-applet:

signal sender=org.freedesktop.DBus -> dest=(null destination) 
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus; 
member=NameOwnerChanged
   string ":1.16"
   string ""
   string ":1.16"

... and I get a similar message when I ctrl-C the applet, except the 
last two string values reverse.  Presumably establishing/disestablishing 
a dbussy relationship between the applet and... something...



>>> I'm not sure what confusion there should be. Use gnome-bluetooth.
>>>   
>>>       
>> Well that clears that up :)  But it isn't that obvious from the state of 
>> the various web pages.
>>     
>
> Which web pages?
>   

I retract this :)  bluez-gnome has fallen off BlueZ's front page now, 
and it isn't referred to on the download page, so the confusion looks 
like it's in the past now...


Whilst I've got you... msgfmt is a bit of a black art to me too so I'm 
not sure this is right, but I needed to make this change to get 
gnome-bluetooth 2.27.8 to build.

--- po/es.po.orig       2009-07-27 23:02:12.975653980 +1200
+++ po/es.po    2009-07-27 23:02:40.186064443 +1200
@@ -794,7 +794,7 @@
 #~ msgid "Enter passkey"
 #~ msgstr "Introducir contraseña"
 
-#~| msgid "Enter passkey"
+#| msgid "Enter passkey"
 #~ msgid "Verify passkey"
 #~ msgstr "Verificar contraseña"

