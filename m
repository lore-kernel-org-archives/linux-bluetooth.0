Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1ffb4b07050112082754160b52@mail.gmail.com>
From: Mike Lee <eemike@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] out of range
In-Reply-To: <1105532053.7961.51.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <41E48785.2010100@avantwave.com> <1105532053.7961.51.camel@pegasus>
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
Date: Thu, 13 Jan 2005 00:27:34 +0800

Dear Marcel 
    Thanks for reply.
     Then how can i determind whether rfcomm is terminated by user or
due to out of range? Or i need to monitor hci msg?

best regard
Mike,Lee



On Wed, 12 Jan 2005 13:14:13 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mike,
> 
> >     Could anyone tell me , how to detect out of range from user
> > application when i am using rfcomm SPP profile?
> 
> the RFCOMM socket will terminate.
> 
> Regards
> 
> Marcel
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


-- 
-------------------------------------------------------
Mike Lee


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
