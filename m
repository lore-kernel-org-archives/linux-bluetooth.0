Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Colin Pinkney <tumnus@dsl.pipex.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bcsp w/ csr chip Mavin CF card
References: <1063773826.2320.9.camel@dev.blackbear.com>
In-Reply-To: <1063773826.2320.9.camel@dev.blackbear.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309171902.05063.tumnus@dsl.pipex.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 17 Sep 2003 19:02:04 +0100

On Wednesday 17 Sep 2003 05:43, Chris Sterling wrote:
> I am using the base installed modules and scripts with slight
> configuration modifications on theKompanyROM for the Zaurus.  It is
> currently on the 2.4.18 kernel.  The Zaurus recognizes the card as the
> Mavin Compact Flash card when it is put in.
>
> Does anybody know how I can modify the scripts or configurations to
> attach using bcsp and maybe give some specifics on files to be modified?
> Thank you in advance.

The BlueZ install on theKompany ROM is broken with respect to UART based CF 
cards. You need to install the latest BlueZ driver package from 
http://community.zaurus.com/projects/bluez/

Then add a line in /etc/bluetooth/uart that follows the format:

<product info>:/dev/ttyS3 bcsp

Where <product info> is the exact text after "product info:" from the output 
of the command 'cardctl ident'

HTH

-- 
Colin Pinkney
http://www.cpinkney.org.uk



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
