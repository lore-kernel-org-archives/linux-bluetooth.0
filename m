Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Moritz Bunkus <moritz@bunkus.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection to Motorola V525 fails
Message-ID: <20040528180635.GA20450@bunkus.org>
References: <20040528154111.GD24083@bunkus.org> <1085766449.3321.50.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1UWUbFP1cBYEclgG"
In-Reply-To: <1085766449.3321.50.camel@pegasus>
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
Date: Fri, 28 May 2004 20:06:35 +0200


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for the quick reply.

> There is no need to change anything and keep auth and encrypt off,
> because you don't want to set your device into security mode 3.

That's what I figured - I just wanted to be sure I've tried everything
before crying for help.

> Send us the binary versions of the dump (with -w and as root).

Sure, here it comes. This has been done on the 2.6.6-mh2 with
bluez-utils 2.7-2. This time I've waited until obexpush times out, so
the complete communication has been captured.

BTW: You don't have to CC me as I've subscribed.

Mosu

-- 
If Darl McBride was in charge, he'd probably make marriage
unconstitutional too, since clearly it de-emphasizes the commercial
nature of normal human interaction, and probably is a major impediment
to the commercial growth of prostitution. - Linus Torvalds

--1UWUbFP1cBYEclgG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="motv525-bin.dump"
Content-Transfer-Encoding: base64

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

--1UWUbFP1cBYEclgG--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
