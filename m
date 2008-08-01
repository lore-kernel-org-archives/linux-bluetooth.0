Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Fri, 1 Aug 2008 12:32:36 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
In-Reply-To: <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808011232.36918.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag 31 Juli 2008 16:03:13 schrieb Marcel Holtmann:
> Also the HCI_RESET thing needs to be turn-around. We always do =A0
> HCI_RESET except for some chips where it will break (old CSR ones for =A0
> example).

OK, I am making a separate patch. I've looked at 2.6.26-mh. It seems
to do the reset only for quirky devices. Is the reversal just planned or am
I looking at the wrong trees?

	Regards
		Oliver
