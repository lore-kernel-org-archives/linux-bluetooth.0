Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CSR experimental uart board!
From: Marcel Holtmann <marcel@holtmann.org>
To: scott.meesseman@alpsautomotive.com
Cc: Daniel Moraes <ra002890@itelefonica.com.br>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <OF40F49FA9.701D9ADF-ON85256E40.00768FF6-85256E40.007698DC@alps_aai.com>
References: 
	 <OF40F49FA9.701D9ADF-ON85256E40.00768FF6-85256E40.007698DC@alps_aai.com>
Content-Type: text/plain
Message-Id: <1077314747.2714.11.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 20 Feb 2004 23:05:47 +0100

Hi Scott,

> For BCSP try hciattach /dev/ttyS0 bcsp 115200 flow
> 
> or for H4
> 
> hciattach /dev/ttyS0 any 115200 flow

it is better to use "hciattach ttyS0 csr 115200 flow".

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
