Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FC50C6.1080600@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Connection issue with headset
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <4d34f3925fsbellon@sbellon.de>
In-Reply-To: <4d34f3925fsbellon@sbellon.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 29 Jan 2005 20:13:10 -0700

stefan,

that's good sleuthing, but rfcomm.conf is used to bind a character 
device in /dev (eg /dev/rfcomm1) to a bluetooth device. btsco does not 
try to use a character device to interact with the headset... it makes a 
straight l2cap connection for control signals and later a sco connection 
for audio transport.

brad

Stefan Bellon wrote:
> Sebastian Roth wrote:
> 
> 
>>>nomade:/home/dh# btsco 00:0b:2e:06:01:2e
>>>Device is 1:0
>>>Voice setting: 0x0060
>>>RFCOMM channel 6 connected
>>
>>You have to press the headset button now!
> 
> 
> Sorry to hi-jack this thread, but I just noticed something regarding my
> problem when I read this.
> 
> When I issue the above, the line "RFCOMM channel x connected" doesn't
> appear at all. You wrote that afterwards I have to press the headset
> button. That means, if that line doesn't appear, the problem isn't with
> the headset, but still with my Bluetooth/rfcomm configuration of the
> computer?
> 
> In that case I got an idea. As I use Bluetooth in order to connect my
> SonyEricsson P900 to the computer as well, I have got set up a
> /etc/bluetooth/rfcomm.conf which looks like this:
> 
> rfcomm1 {
>         bind yes;
>         device 00:0A:D9:E9:BB:0A;
>         channel	1;
>         comment "P900 Serial Protocol connection";
> }
> 
> rfcomm11 {
>         bind yes;
>         device 00:0A:D9:E9:BB:0A;
>         channel 11;
>         comment "P900 p3nfsd connection";
> }
> 
> Do I have to add something like ...
> 
> rfcomm2 {
>         bind yes;
>         device 00:07:A4:21:1D:86;
>         channel 2;
>         comment "Jabra BT800";
> }
> 
> ... in order to make it work with btsco? In any case, adding the above
> channel 2 configuration doesn't work. Or don't I have to touch the
> rfcomm.conf at all?
> 
> Perhaps this gives some clues what I'm doing wrong?
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
