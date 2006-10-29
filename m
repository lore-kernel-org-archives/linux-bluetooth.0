Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4544D62E.7040100@xmission.com>
Date: Sun, 29 Oct 2006 09:26:22 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4540D480.1030203@free.fr>
	<4541CA6E.4010003@free.fr>	<4541F314.10408@xmission.com>
	<4544A47A.2040104@free.fr>
In-Reply-To: <4544A47A.2040104@free.fr>
Subject: Re: [Bluez-users] btsco fails: control open (hw:1): No such device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

fabrice

> I had a look at
>> https://help.ubuntu.com/community/BluetoothAudio
> What should my .asoundrc look like with btsco stuff ?
> 
> I'm not sure this .asoundrc is ok.
> 
> fabricer@FR-PORT:~$ cat .asoundrc
> pcm.bluetooth {
>         type a2dp
>         bdaddr "00:03:89:AB:3D:76"
> }
> 
> cuz, i don't use a2dp but btsco instead.

there is a longer example asound.conf in cvs now. update cvs then you
should copy alsa-plugins/asound.conf over your .asoundrc and edit it to
put your headset address in the right spot.

brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
