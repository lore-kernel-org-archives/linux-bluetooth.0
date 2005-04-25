Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] file transfer from phone to PC
Message-Id: <20050425162336.6e3448af.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <20050330174856.17375.qmail@web8505.mail.in.yahoo.com>
References: <20050330174856.17375.qmail@web8505.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 25 Apr 2005 16:23:36 +0200

Hi Maha,

I guess you want to get opd (object push daemon), install it, start hcid
and sdpd then start "opd --mode OBEX --channel 10 --sdp --path ."

Then you can send files from your mobile by selecting it on the mobile
and seach the context options for something like send file -> via
Bluetooth.

Greetings

Andy

On Wed, 30 Mar 2005 18:48:56 +0100 (BST)
mahabaleshwara k <mahabaleshwara_k@yahoo.co.in> wrote:

> Hi all,
> I am trying for file transfer between PC and MOTOROLA
> mobile-E398 over bluetooth.I am having linux-2.4.20
> kernel with blueZ libs, utilis,openobex and obexftp
> compiled. I am able to transfer(put) images from PC to
> mobile using obexftp but NOT FROM MOBILE TO PC. Can
> any one suggest me solution or where I went wrong?
> Regards,
> Maha.
> 
> 
> _____________________________________________________________________
> ___ Yahoo! India Matrimony: Find your life partner online
> Go to: http://yahoo.shaadi.com/india-matrimony
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real
> users. Discover which products truly live up to the hype. Start
> reading now. http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
