Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Jun 2010 10:38:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
Message-ID: <20100622073841.GA13989@jh-x301>
References: <4C206507.40402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C206507.40402@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 22, 2010, Jiri Slaby wrote:
> I have a problem with receiving files with obexd. After it receives
> header (file name etc.) it hangs up the connection with
> obex_handle_input: poll event HUP ERR

libopenobex seems to be indicating REQDONE, so it doesn't look like
anything is necessarily wrong with obexd here. However, you'd need to
look at the HCI level trafic (output of "hcidump -XV") to determine
what's really going on (e.g. is it obexd or the client that's
disconnecting).

Johan
