Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Patrick Duchstein <patrick@duchstein.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm connection setup
Message-Id: <20040609030049.0a9212bd.patrick@duchstein.com>
In-Reply-To: <1086735971.5040.52.camel@pegasus>
References: <20040608230122.3504775c.patrick-bluez.org@prote.st>
	<1086735971.5040.52.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__9_Jun_2004_03_00_49_+0200_p=/EmyGc4sY8w+XR"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 9 Jun 2004 03:00:49 +0200


--Multipart=_Wed__9_Jun_2004_03_00_49_+0200_p=/EmyGc4sY8w+XR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jun 2004 01:06:11 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> since you mention "rctest -s -N 2" I assume that you try to connect
> from BlueZ to your stack. Run "hcidump -w <file>" as root on the BlueZ
> side and show us the resulting file.
yep that's correct. I attached the resulting file; l2cap parameter
negotiation (conf_req/conf_rsp from both sides) runs without problems,
and then nothing else happens, whilst IMHO bluez should send SABM.

Btw, is there a reason for bluez rejecting non-default l2cap parameters,
such as a smaller MTU? I might consider implementing this into bluez
when I find the time if it is desired at all....at least by me it
definitely is since I'm working on only 4KB of RAM.

Again, thanks for your help.

/Patrick

--Multipart=_Wed__9_Jun_2004_03_00_49_+0200_p=/EmyGc4sY8w+XR
Content-Type: application/octet-stream;
 name="dump"
Content-Disposition: attachment;
 filename="dump"
Content-Transfer-Encoding: base64

EQAAAMJcxkBXMgsAAQUEDYGcFzeAABjMAgAAAAEHAAEAwlzGQBFNCwAEDwQAAQUEDgABAMJcxkCR
ew0ABAMLACkAgZwXN4AAAQARAAAAwlzGQNh7DQACKSAMAAgAAQACAQQAAwBAAAgAAADCXMZA5nsN
AAENCAQpAA4ACAABAMJcxkDprA0ABBMFASkAAQAJAAEAwlzGQD+yDQAEDgYBDQgAKQAVAAEAwlzG
QFFcDgACKSAQAAwAAQADAQgAQABAAAAAAAAVAAAAwlzGQJBcDgACKSAQAAwAAQAEAggAQAAAAAEC
AAQGAAEAwlzGQOJ0DgAEGwMpAAUIAAEAwlzGQG95DgAEEwUBKQABABQAAQDCXMZAwsQOAAIpIA8A
CwABAAUCBwBAAAAAAwAEEQAAAMJcxkAJxQ4AAikgDAAIAAEABgMEAEAAQAARAAEAwlzGQFzPDgAC
KSAMAAgAAQAEAwQAQAAAABMAAADCXMZAo88OAAIpIA4ACgABAAUDBgBAAAAAAAAIAAEAwlzGQHTh
DgAEEwUBKQABAAgAAQDCXMZAzeYOAAQTBQEpAAEABwAAAMlcxkAW0g4AAQYEAykAEwcAAQDJXMZA
1OwOAAQPBAABBgQHAAEAyVzGQEkJDwAEBQQAKQAW

--Multipart=_Wed__9_Jun_2004_03_00_49_+0200_p=/EmyGc4sY8w+XR--


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
