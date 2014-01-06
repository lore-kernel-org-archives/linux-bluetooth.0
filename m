Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jan 2014 18:42:34 +0100
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, peter@hurleysoftware.com,
	"linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Regression fixes for rfcomm/tty.c
Message-ID: <20140106174234.GA23339@sottospazio.it>
References: <1388853038-6917-1-git-send-email-gianluca@sottospazio.it>
 <D4D6DA93-0C44-4F35-AD45-9EDE4775B052@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D4D6DA93-0C44-4F35-AD45-9EDE4775B052@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 06, 2014 at 09:35:18AM -0800, Marcel Holtmann wrote:
> Hi Gianluca,
> 
> I applied both patches to bluetooth-next to expose them wider testing. I like to have them go through bluetooth-next first before we push them back into -stable.
> 
> Regards
> 
> Marcel
> 

Thank you for the reply, however there is another regression and the fix would
make the second patch unnecessary.

Would it be better if I resend a second iteration of patches? There would be 4
patches, two fixes and two which move code around.
