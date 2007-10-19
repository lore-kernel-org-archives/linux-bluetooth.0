Return-Path: <fchevalier@silicom.fr>
Message-ID: <4718E8E0.5050608@silicom.fr>
Date: Fri, 19 Oct 2007 19:26:56 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@xmission.com>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>, thiagossantos@gmail.com,
        Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [PATCH] newapi patch v1
Content-Type: multipart/mixed;
 boundary="------------060506050409090709080507"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060506050409090709080507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


All, here is the first version of the patch that moves to the newapi
usage... yeheee !!
As nobody suggested a new name, i've just chose one, which is
"btaudioservice.h" :-). Of course this can be changed if somebody
prefers a better name :-)

This patch does not bring any new feature by itself, it's goal is only
to get rid from the ipc.h stuff. However is is already quite big, but i
really can't make it smaller without breaking stuff that is known to
work today :-(

I did some basic testing of the patch, which is:
   - play a file using a2dp, seek during playing (audacious)
   - play a file using a2dp, seek during playing (rhythmnbox)
   - play a file using SCO, seek during playing (audacious)
   - record and play file using aplay & arecord.

I didn't notice any regression, but i don't want to fool anybody : such
a big patch will inevitably bring its set of regressions, it's just that
i haven't found them yet :-)

Due to the fairly big nature of the patch, i would suggest to wait for
3.21 before moving to the new api, this will give us the usual time
between two bluez releases to :
   - fix regressions introduced (my job :-) )
   - upgrading the gstreamer plugin to use the new api ( i'd prefer
thiagoss to work on this one (with my support of course), as i've never
put my nose on this part of the code )

As usual, comments are welcome. ;-)

Cheers,

Fabien


--------------060506050409090709080507
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
--------------060506050409090709080507--
