Return-Path: <jjbrucker@free.fr>
From: Jean-Jacques Brucker <jjbrucker@free.fr>
To: bluez-devel@lists.sourceforge.net
Subject: hcid pairing bug when security is auto
Date: Fri, 29 Sep 2006 22:08:33 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <17692.1030.64904.774688@altoids.csail.mit.edu> <1159530640.6131.31.camel@localhost>
In-Reply-To: <1159530640.6131.31.camel@localhost>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B1XHFsbdVlNY4Yl"
Message-Id: <200609292208.33700.jjbrucker@free.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

--Boundary-00=_B1XHFsbdVlNY4Yl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 There was a bug in hcid when pairing and security is in auto mode.

The code watched if the connection was out or in , but in any case the remote 
device can ask or not for authentication (and encryption).

By example Sagem and Ericsson mobile phones ask for authentication/encryption 
with new devices, whithout watching who is trying to connect first ... !

 Then the code was looking for pincodes in a file 
"/var/lib/<local_bdaddr>/pincodes" but that wasn't write by any know 
applications. (and it is not a place to make file to be write by users...).

Then the code was trying to give the hand to dbus applications ("hey, what 
this f... i have ask for auto mode !!").

 As i didn't know if there was some software that use the 
"/var/lib/<local_bdaddr>/pincodes" file i let this file as a first base to 
search and i have add a config file with the same name (but without the same 
syntax) in the bluez config directory.

Note: Using dbus is a good idea, but it would better to activate it or not 
with a flag. Because dbus is very big to be embedded on small (and embedded) 
systems...

Note2: I have watch in CVS that bluez used a file named pin in confdir... What 
i have done is not really a regression. In fact we could insert the content 
of the pincodes file inside the hcid.conf file .... but I don't really know 
how to do it with bison (and i dislike bisons !-). At the end the syntax of 
my pincodes file is simple and is read on each HCI "PIN code request" command 
(when security is set to auto)  and could be more easily manage by extern 
software (that doesn't use dbus).

PS: I have make the hcid.conf more explicit but I don't  have patch man pages 
for now, but if my patch is used, i'll obviously update them. (and with our 
without my patch, its already need some updates..).


--Boundary-00=_B1XHFsbdVlNY4Yl
Content-Type: application/x-gzip;
  name="hcid_autopairing.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="hcid_autopairing.patch.gz"

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

--Boundary-00=_B1XHFsbdVlNY4Yl--
