Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300707052037n77cde792lef76d30364998959@mail.gmail.com>
Date: Thu, 5 Jul 2007 21:37:46 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <87ir8ytn5n.fsf@grogan.peloton>
MIME-Version: 1.0
References: <87ir8ytn5n.fsf@grogan.peloton>
Subject: Re: [Bluez-users] hidd connection to mouse interferes with headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dave

if you have "master" in hcid.conf's lm setting and you take "rswitch"
and "sniff" out of the lp setting, you are forcing the pc to be master
and to hopefully behave better with audio. restart hcid.

brad

On 7/5/07, David Abrahams <dave@boost-consulting.com> wrote:
> and try to use Skype again, I get horrible distortion, from "choppy
> sound" to "white noise"

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
