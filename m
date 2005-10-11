Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <434C16C4.3040009@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: hcid patch (remote name and connections)
References: <e1effdeb0510110726k15f2bdx405606b1f6d3a297@mail.gmail.com> <e1effdeb0510110749jf47c023ne87567fba3d65937@mail.gmail.com>
In-Reply-To: <e1effdeb0510110749jf47c023ne87567fba3d65937@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 11 Oct 2005 20:47:16 +0100

Claudio Takahasi wrote:
> +	if (!(cl = malloc(10 * sizeof(*ci) + sizeof(*cl)))) { 
...
> +	cl->conn_num = 10;

*cough* magic number *cough*

	- Steven
-- 


This message has been scanned for viruses by BlackSpider MailControl - www.blackspider.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
