Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm socket and rfcomm tty
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <I9R9DH$87B77B69F7EC05E925293D07675091B6@uol.com.br>
References: <I9R9DH$87B77B69F7EC05E925293D07675091B6@uol.com.br>
Content-Type: text/plain
Message-Id: <1104781933.8894.64.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 03 Jan 2005 20:52:13 +0100

Hi,

> int main(void)
> {
> 		int sock, client, alen;
> 		struct sockaddr_rc addr;
> 
> 		if (sock = socket(AF_BLUETOOTH,
> SOCK_STREAM, BTPROTO_RFCOMM) < 0) {
>  				perror("socket");
>  				exit(1);
>   		}
> 
> 		addr.rc_family = AF_BLUETOOTH;
> 		bacpy(&addr.rc_bdaddr, BDADDR_ANY);
> 		addr.rc_channel = htobs(CHANNEL);

you don't need a byteswap here. The rc_channel is only uint8_t.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
