Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W36DC3BCBD6F4A6049B58B5C0980@phx.gbl>
From: "" <semiyd@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sat, 20 Oct 2007 08:05:08 +0000
In-Reply-To: <BAY117-W365D761B4CBEBB2EC809FFC09F0@phx.gbl>
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
	<4717360C.7090801@free.fr>	<BAY117-W28974EACDCC899AC3DF807C09E0@phx.gbl>
	<47175ACD.8030609@free.fr>
	<BAY117-W206976481AC34B06264B43C09F0@phx.gbl>
	<BAY117-W365D761B4CBEBB2EC809FFC09F0@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] SCO connection timed out issue
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi Fabien:
     I got a clue after printf lots of information from the kernel about
my "aplay: main:550: audio open error: Input/output error" after using "apl=
ay -D bluetooth /1.wav".
     In bluez-utils-3.20/audio/pcm_bluetooth.c
           It has a function named:
                 static int bluetooth_cfg(struct bluetooth_data *data,
snd_pcm_stream_t stream,
                       snd_config_t *conf)

                 and the Input/Output error comes from bluetooth_cfg():
***************************************************************************=
************************
     ret =3D send(data->server.fd, pkt, sizeof(*pkt) + pkt->length, 0);
     if (ret < 0)
           return -errno;
     else if (ret =3D=3D 0)
           return -EIO;

     DBG("OK - %d bytes sent. Waiting for response...", ret);

     memset(buf, 0, sizeof(buf));

     ret =3D recv(data->server.fd, buf, sizeof(*pkt) + sizeof(*cfg), 0);
     if (ret < 0)
           return -errno;
     else if (ret =3D=3D 0)
           return -EIO;//This is where Input/Output error come from.
***************************************************************************=
************************
That means after recv(data->server.fd, buf, sizeof(*pkt) + sizeof(*cfg),
0);, it returns a wrong value.

Here's the debug message related to this error:
DEBUG: _snd_pcm_bluetooth_open: Bluetooth PCM plugin (Playback)
DEBUG: bluetooth_init: Connecting to address: /org/bluez/audio
DEBUG: bluetooth_cfg: Sending PKT_TYPE_CFG_REQ...
DEBUG: bluetooth_cfg: OK - 34 bytes sent. Waiting for response...

After Sending PKT_TYPE_CFG_REQ, it seems it didn't
recieve(recv(data->server.fd, buf, sizeof(*pkt) + sizeof(*cfg), 0);) the
proper information.

Can you give me any hints? Is this about PKT_TYPE_CFG_REQ or my .asoundrc
configuration?
***************************************************************************=
***********************************

PS:This is my .asoundrc:
#pcm.a2dpd {
#            type a2dpd
#           }

pcm.bluetooth {
  type bluetooth
     device 00:0D:3C:EB:53:F0
}

#pcm.!default {
#        type hw
#        card 0
#        device 0
#}

pcm.card0 {
   type hw
   card 0
}
ctl.card0 {
   type hw
   card 0
}
***************************************************************************=
************************************



thanks


semiyd




> From: semiyd@hotmail.com
> To: bluez-devel@lists.sourceforge.net
> Date: Fri, 19 Oct 2007 05:55:35 +0000
> Subject: Re: [Bluez-devel] SCO connection timed out issue
>
>
> Hi Fabien:
> Just got comfirm from ST. No support for sco over hci ;-(
> They said uncless i buy a mother board with hw-codec and connect it to th=
e STLC2500 adapter .
>
> About the command "aplay -D bluetooth /1.wav", i have question here:
> Is this command aimed to connect the headset over A2DP? Or will it automa=
tically adjust the link type between A2DP and SCO accoring to the actual si=
tuation?
> And , is there any command that is aimed to do A2DP with the headset that=
 i can use ?
>
>
>
> Thanks!
>
>
>
> semiyd
>
>
>
>> From: semiyd@hotmail.com
>> To: bluez-devel@lists.sourceforge.net
>> Date: Fri, 19 Oct 2007 03:16:00 +0000
>> Subject: Re: [Bluez-devel] SCO connection timed out issue
>>
>>
>> Hi Fabien:
>> *Firstly, i could only find the 'data brief' datasheet of
>> STLC2500C,which has very little information.No more detailed datasheet
>> could be found...
>>
>> (http://www.st.com/stonline/products/literature/bd/12019/stlc2500c.pdf)
>> I also found something.Maybe related to SCO.In the datasheet,it says:
>> "
>> Communication interfaces
>> -PCM interface for voice
>> "
>> I don't know if this is indicating that the chip only supports sco
>> over pcm,not hci,or something else...Anyway , no further info about SCO =
can
>> be found in this datasheet.I also wrote an email to the ST technical
>> support team to comfirm the stuff.
>>
>> *I looked into the source code in the driver of pl2303 in my
>> linux.It's true that the max baudrate the driver supports is 460800.
>> I'm now using the command 'hciattach ttyUSB0 stlc2500 460800 '.
>>
>> *About the error:
>> aplay: main:550: audio open error: Input/output error
>> hcid[318]: Service owner exited: :1.2
>> hcid[318]: Audio service (audio) was killed by signal 7
>> It's like this:I'm developing on an embeded system(S3c2410 EVB).So
>> i have to mount the root file system(mounted root) through NFS.I tried g=
db
>> before and seems there's something wrong when gdb goes into the content =
of
>> NFS(my 'aplay'and some other programmes are in the file system from NFS)=
.I
>> got the following error from gdb when mounting on NFS:
>>
>> Program received signal SIGTRAP, Trace/breakpoint trap
>>
>> This error will force the gdb into a single step mode .That mode begins
>> when the system just started to mount the root FS from NFS.
>> But the GDB is okey with ramdisk-based file systems.
>> So maybe i should create a ramdisk with all the necessary components of
>> ALSA and bluez and try the GDB again.
>>
>>
>> thanks
>>
>>
>> yandong
>>> Date: Thu, 18 Oct 2007 15:08:29 +0200
>>> From: fabchevalier@free.fr
>>> To: bluez-devel@lists.sourceforge.net
>>> Subject: Re: [Bluez-devel] SCO connection timed out issue
>>>
>>> Please find some comments below
>>>>
>>>> * Im confused about what you said about the sco function on STLC2500C.=
According to the IC datasheet of STLC2500C downloaded from 'www.st.com', it=
 says that this chip supports SCO link. So are you saying that this chip si=
mply can't support SCO under linux?(i have a couple of evaluation software =
of STLC2500C evaluation board under windowXP.It seems that under windows , =
its SCO link works.But im not very sure about this.)
>>>
>>> It's basically not in the datasheet, but it is how things are. The chip
>>> supports SCO but not over hci, only over PCM.
>>> It won't work with windows either :-(
>>>
>>>>
>>>> * i followed your hint and used the command "hciattach ttyUSB0 stlc250=
0" and then got the following information:
>>>> Loading file /lib/firmware/STLC2500_R4_02_04.ptc
>>>> Loading file /lib/firmware/STLC2500_R4_02_02_WLAN.ssf
>>>> STLC2500 R4.2 12102005 12:40:14
>>>> ZAV100012 05HW Id=3D V440BAA
>>>>
>>>> i copied 2 files:
>>>> STLC2500_R4_02_02_WLAN.ssf
>>>> STLC2500_R4_02_04.ptc
>>>> from the bluez-firmware-1.2/st to the /lib/firmware folder.
>>>>
>>>> i didn't use the "hciattach ttyUSB0 stlc2500 921600" cause this will g=
ive the following error:
>>>> pl2303 ttyUSB0: pl2303 driver does not support the baudrate requested =
(fix it)
>>>> It seems the pl2303(the serial-USB converter IC on STLC2500C evaluatio=
n board) driver does not support the baudrate of 921600.
>>>
>>> Yes that's true, you need a 2.6.23 kernel for this high speed. With
>>> 2.6.18 you should be able to go to 460800 bps though, please retry with
>>> hciattach ttyUSB0 stlc2500 460800
>>>
>>>
>>>>
>>>> So up to now , some good improvements have been made thanks to your su=
ggestion. Anyway , i got the same err when i tried to connect using the com=
mand :aplay -D bluetooth /1.wav
>>>> aplay: main:550: audio open error: Input/output error
>>>> hcid[318]: Service owner exited: :1.2
>>>> hcid[318]: Audio service (audio) was killed by signal 7
>>>> hcid[318]: link_key_request (sba=3D00:80:E1:00:00:00, dba=3D00:0D:3C:E=
B:53:F0)
>>>
>>> I have no idea of what's going wrong either. If you attach gdb to the
>>> bluetoothd-service-audio and show me where the program breaks i could
>>> tell more.
>>>
>>> Cheers,
>>>
>>> Fabien
>>>
>>> -----------------------------------------------------------------------=
--
>>> This SF.net email is sponsored by: Splunk Inc.
>>> Still grepping through log files to find problems? Stop.
>>> Now Search log events and configuration files using AJAX and a browser.
>>> Download your FREE copy of Splunk now>> http://get.splunk.com/
>>> _______________________________________________
>>> Bluez-devel mailing list
>>> Bluez-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>> _________________________________________________________________
>> Explore the seven wonders of the world
>> http://search.msn.com/results.aspx?q=3D7+wonders+world&mkt=3Den-US&form=
=3DQBRE
>>
>
> _________________________________________________________________
> Invite your mail contacts to join your friends list with Windows Live Spa=
ces. It's easy!
> http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friend=
s.aspx&mkt=3Den-us
>

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline
-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
