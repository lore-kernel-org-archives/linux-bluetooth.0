Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040806195016.5b379fc9.Andreas.Gaufer@blue-cell-networks.com>
References: <34A116F6-E7C6-11D8-B421-000A959E26AE@ermy.net> <20040806195016.5b379fc9.Andreas.Gaufer@blue-cell-networks.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <501B4DE6-EB16-11D8-8E8C-000A959E26AE@ermy.net>
Cc: Bluez Devel <bluez-devel@lists.sourceforge.net>
From: Mark Thompson <lists@ermy.net>
Subject: Re: [Bluez-devel] L2CAP_CONN_TIMEOUT without recompiling kernel?
To: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Aug 2004 22:43:27 +0100


On Aug 06, 2004, at 18:50, Andreas Gaufer wrote:
>
> I guess the timeout you are searching for is the page-time out. This
> timer is managed on the chip an can be changed with "hciconfig hciX
> pageto n" (if what your using is a usb device). man hciconfig also has 
> a
> lot of info.

You're absolutely right.

Thanks for the pointer - client code fixed :)

Mark/



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
