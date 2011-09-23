Return-Path: <cyrus@holtmann.org>
Message-ID: <4E7C598C.8050309@bmw-carit.de>
Date: Fri, 23 Sep 2011 12:03:56 +0200
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: SCO control in HansfreeGateway
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Some recent patches have made that the State property in 
HandsfreeGateway exposes if the SCO connection is active or not. As far 
as I understand, the state Playing is specifically added for this reason.

However, I don't see any way in the D-Bus API to control the state of 
this connection. One example would be that a phone would drop the audio 
connection (it is allowed to do so at any time) but the user wants this 
connection to be re-established.

Wouldn't this require the addition of some methods like ConnectAudio and 
DisconnectAudio in the HandsfreeGateway interface?

Regards,
Mikel

