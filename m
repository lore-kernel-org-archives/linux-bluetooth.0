Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4720DF23.6040607@silicom.fr>
Date: Thu, 25 Oct 2007 20:23:31 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/mixed; boundary="------------020404050708000006080802"
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Brad Midgley <bmidgley@xmission.com>
Subject: [Bluez-devel] Bluez DBUS API usuability regarding end user
	experience
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020404050708000006080802
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Marcel,

I have a (kind of) formal request to ask to the Bluez project.

I'm basically trying to use the Bluez API to design a user friendly 
device that will have bluetooth functionnality.
Speeking of a user friendly device, i'm thinking of two things i wanna have:
   - the end user bluetooth feature should work most of the time, which
means it will have to be robust and not throw errors most of the time.
   - When something goes wrong, the end user should only be presented 
with error messages he can understand and actually act upon. If the 
message is too cryptic, then a generic placeholder would be use instead 
of a low level message. One of the first non cryptic messages i think of 
would be a "Device unreachable : please check your bluetooth device is 
powered on" message :-)

I've done a quick review of hcid an audio service code, and did some 
testing too. What i've found is:
  - for hcid case: the closed match i found is the 
org.audio.bluez.ConnectionAttemptFailed exception. This one seems to be 
raised when the L2CAP connection fails. But it is not specific on the
failure cause ( i think what i'm looking for is EHOSTDOWN posix error 
code, please correct me if i'm wrong ;-) )
  - for Audio service the case is different. Sink object Connect() dbus 
call would fail with org.bluez.audio.Error.Failed while the Headset 
object Connect() dbus call would fail with 
org.bluez.audio.Error.ConnectFailed. Those two are not even consistent :-(
headset.c code looks even a bit hackish, as it tryes to regenerate the 
lost EHOSTDOWN error code by hand :

if (dbus_error_has_name(&derr,						 
"org.bluez.Error.ConnectionAttemptFailed"))
	err_connect_failed(device->conn, c->msg,
					strerror(EHOSTDOWN));

My point of view is that this common case of error should be clearly 
identified and sent up to the application.

What i would like to do is propose a patch that would:
   - Define org.bluez.Error.DeviceUnreachable exception for hcid. This 
would be fired each time a connect on an l2cap socket would return 
EHOSTDOWN.
   - Define org.bluez.Error.Audio.DeviceUnreachable for use by the audio 
service. This one would be sent by the Headset and Sink objects instead 
of the org.bluez.audio.Error.Failed and 
org.bluez.audio.Error.ConnectFailed when the l2cap/rfcomm/sco connect() 
code returns EHOSTDOWN.

Marcel, would you agree this is the right way to proceed ? Would you be 
willing to accept patches that move the code in that direction ?
( I mean : shall i start coding now ? ;-) )

Regards,

Fabien


--------------020404050708000006080802
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fchevalier.vcf"

YmVnaW46dmNhcmQNCmZuOkZhYmllbiBDSEVWQUxJRVINCm46Q0hFVkFMSUVSO0ZhYmllbg0K
b3JnOlNJTElDT00NCmFkcjo7OzQgcnVlIGRlIEpvdWFuZXQ7IFJFTk5FUyBBVEFMQU5URTs7
MzU3MDA7RlJBTkNFDQplbWFpbDtpbnRlcm5ldDpmY2hldmFsaWVyQHNpbGljb20uZnINCnRp
dGxlOlNvZnR3YXJlICYgU3R1ZGllcyBFbmdpbmVlcg0KdGVsO3dvcms6KzMzICgwKSAyIDk5
IDg0IDE3IDE3DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------020404050708000006080802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------020404050708000006080802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020404050708000006080802--
