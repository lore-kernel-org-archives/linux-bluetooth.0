Return-Path: <honza@sis.vutbr.cz>
Date: Fri, 2 Jul 2004 14:35:26 +0200
From: Jan Sobek <honza@sis.vutbr.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth - 6310i - iBook
Message-ID: <20040702123526.GA32744@sis.vutbr.cz>
References: <20040702105653.GF13439@sis.vutbr.cz> <1088766165.2803.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088766165.2803.0.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, Jul 02, 2004 at 01:02:46PM +0200, Marcel Holtmann wrote:
| Hi Jan,
|
| > I'm trying to connect ibook and nokia 6310 using bluetooth adapter by
| > microcom.
| > 
| > same configuration works for me on my desktop, but on ibook works
| > only.
| > 	hcitool scan
| > 	hcitool info xx.xx.xx.xx.xx.xx
| > 
| > gnokii --monitor
| > GNOKII 0.6.1
| > Couldn't open PHONET device: No such file or directory
| > Telephone interface init failed: Command failed.
| > Quitting
| > 
| > rfcomm connect rfcomm0 xx.xx.xx.xx.xx.xx
| > Can't connect RFCOMM socket: Connection refused
| 
| run "hcidump -x" as root while your are trying to connect with Gnokii
| and show it to us.

# hcidump -x
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff



-- 
Honza
