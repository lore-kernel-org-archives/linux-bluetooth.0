Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <bd5b16740704300324i5f4f527aq50777d136e7a108f@mail.gmail.com>
Date: Mon, 30 Apr 2007 13:24:24 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: "Sumeet VERMA" <sumeet.verma@st.com>
In-Reply-To: <4f436aae0704300204s36b603faia97cb5c6452e425c@mail.gmail.com>
MIME-Version: 1.0
References: <1177597177.14980.71.camel@aeonflux.holtmann.net>
	<01fc01c78ae5$c0c5c980$8935c70a@dlh.st.com>
	<4f436aae0704300204s36b603faia97cb5c6452e425c@mail.gmail.com>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Low Power mode in bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Sumeet,

> From: Sumeet VERMA <sumeet.verma@st.com>
>
> I meant deep sleep modes by low power modes. I think I would need some
> support in bluetooth transport layer for that.

I'm not so sure what is it that you need, but it sounds like the kernel patch
I sent earlier today might be of interest to you; The patch implements
deep sleep
modes via transport layer manipulations (the patch is actually a new
HCI line discipline protocol).

These deep sleep modes are part of TI's HCILL runtime power management
UART protocol.

BR,
Ohad.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
