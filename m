Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Mar 2011 19:54:08 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/6] Sim Access Profile Server
Message-ID: <20110315175408.GC16335@jh-x301>
References: <1300207401-23438-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300207401-23438-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300207401-23438-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Tue, Mar 15, 2011, Waldemar Rymarkiewicz wrote:
> Add a Sim Access Server to the SAP plugin and a framework for the dummy
> sap driver as well.
> 
> 	* add the server register and unregister rutines
> 	* add server listening socket setup
> 	* add SAP DBus API
> 	* add prototypes for SAP protocol implementation
> 	* add skeleton of dummy SIM driver
> ---
>  Makefile.am     |    3 +-
>  sap/sap-dummy.c |   85 ++++++++
>  sap/sap.h       |  186 +++++++++++++++++
>  sap/server.c    |  612 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 878 insertions(+), 8 deletions(-)
>  create mode 100644 sap/sap-dummy.c
>  create mode 100644 sap/sap.h

I've pushed the first two patches in this set, but it's gonna take quite
a bit longer to properly review the rest (at a quick glance I noticed at
least some coding style stuff with over 80-character lines). So the rest
will have to wait until after the next BlueZ release (which will
hopefully happen still today).

Johan
