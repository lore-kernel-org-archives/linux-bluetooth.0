Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        bluez-devel-bounces@lists.sourceforge.net
Message-ID: <OF8924A15A.C478BABF-ON4825737A.000A932C@mxic.com.cn>
From: KyoYin@mxic.com.cn
Date: Sat, 20 Oct 2007 10:10:24 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-devel] bluetooth headset not working
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net



hi johan

>Actually bluetoothd-service-audio takes care of both A2DP and HSP.
>Unless you specified explicitly the profile to use in your .asoundrc
>(e.g. "profile a2dp") the selection process goes as such that A2DP is
>used if available and otherwise HSP.

      Do u mean the bluetoothd-service-audio will read .asoundrc?
      could you tell me how to write .asoundrc if i want to use a2dp and
hsp.now my .asoundrc is:

      pcm.headset {
      type bluetooth
      }

      ctl.headset {
      type bluetooth
      }

      pcm.bluetooth {
      type bluetooth
      device 00:0D:3C:EB:53:F0
      }

when i use  "aplay -D bluetooth -f S16_LE /1.wav ",i will get the following
error.


audio[837]: Accepted new client connection on unix socket (fd=7)
audio[837]: Package PKT_TYPE_CFG_REQ:0
audio[837]: avdtp_ref(0x37ef8): ref=2
audio[837]: a2dp_source_request_stream: selected SEP 0x376b8
audio[837]: avdtp_ref(0x37ef8): ref=3
hcid[825]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
hcid[825]: pin_code_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
hcid[825]: link_key_notify (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
audio[837]: AVDTP: connected signaling channel to 00:0D:3C:EB:53:F0
audio[837]: session_cb
audio[837]: DISCOVER request succeeded
audio[837]: seid 1 type 1 media 0 in use 0
audio[837]: seid 2 type 1 media 0 in use 0
audio[837]: session_cb
audio[837]: GET_CAPABILITIES request succeeded
audio[837]: seid 1 type 1 media 0
hcid[825]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
audio[837]: session_cb
audio[837]: GET_CAPABILITIES request succeeded
audio[837]: seid 2 type 1 media 0
audio[837]: Discovery complete
audio[837]: avdtp_set_configuration(0x37ef8): int_seid=1, acp_seid=1
audio[837]: session_cb
audio[837]: SET_CONFIGURATION request succeeded
audio[837]: SBC Source: Set_Configuration_Cfm
audio[837]: avdtp_ref(0x37ef8): ref=4
audio[837]: stream state changed: IDLE -> CONFIGURED
audio[837]: session_cb
audio[837]: OPEN request succeeded
audio[837]: stream state changed: CONFIGURED -> OPEN
audio[837]: AVDTP: connected transport channel to 00:0D:3C:EB:53:F0
audio[837]: SBC Source: Open_Cfm
audio[837]: session_cb
audio[837]: START request succAlignment trap: bluetoothd-serv (837)
PC=0x0001ce50 Instr=0xe1c320b0 Address=0xbe871a89 FSR 0x813
eeded
audio[837]: SBC Source: Start_Cfm
audio[837]: SBC Source SEP 0x376b8 locked
hcid[825]: Service owner exited: :1.1
hcid[825]: Removing record with handle 0x10000
hcid[825]: Service classes 0x08
hcid[825]: Removing record with handle 0x10001
hcid[825]: Service classes 0x00
aplay: main:546: audio open error: Input/output error
hcid[825]: Audio service (audio) was killed by signal 7
/ $ hcid[825]: link_key_request (sba=00:80:E1:00:AB:BA,
dba=00:0D:3C:EB:53:F0)
hcid[825]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)

i do not know the reason,and i have used alsa-lib-1.0.15/alsa-utils-1.0.15
/dbus-1.02/dbus-glib-0.74/glib-2.12.13/blueZ-lib-3.20/blueZ-utils-3.20
if i lack some lib?or my configure is wrong?

thanks


kyo



|---------+----------------------------------------->
|         |           Johan Hedberg                 |
|         |           <johan.hedberg@gmail.com>     |
|         |           Sent by:                      |
|         |           bluez-devel-bounces@lists.sour|
|         |           ceforge.net                   |
|         |                                         |
|         |                                         |
|         |           2007-10-20 00:42              |
|         |           Please respond to BlueZ       |
|         |           development                   |
|         |                                         |
|---------+----------------------------------------->
  >-------------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                               |
  |       To:       BlueZ development <bluez-devel@lists.sourceforge.net>                                                         |
  |       cc:                                                                                                                     |
  |       Subject:  Re: [Bluez-devel] bluetooth headset not working                                                               |
  >-------------------------------------------------------------------------------------------------------------------------------|





On Oct 19, 2007, at 19:03, Jim Carter wrote:
> I've seen a similar message when I didn't have bluetoothd-service-
> audio
> configured to autostart and forgot to start it manually.  Do you
> have the
> corresponding protocol/profile daemon running?  I don't have my laptop
> handy to look up the name of this daemon but I think it's
> bluetoothd-service-sco.

Actually bluetoothd-service-audio takes care of both A2DP and HSP.
Unless you specified explicitly the profile to use in your .asoundrc
(e.g. "profile a2dp") the selection process goes as such that A2DP is
used if available and otherwise HSP.

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel




-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
