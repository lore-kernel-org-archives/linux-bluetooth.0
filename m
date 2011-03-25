Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 11:14:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Sim Access Profile test scripts
Message-ID: <20110325091447.GB31700@jh-x301>
References: <1300973581-32639-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300973581-32639-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, Mar 24, 2011, Waldemar Rymarkiewicz wrote:
> Add simple SAP client python implementation and a test script.
> 
> To run test-sap-server you need Python 2.6 or newer (tested with 2.6 only)
> and PyBluez package installed.
> ---
>  Makefile.tools       |   17 +-
>  test/sap-client      |  944 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  test/test-sap-server |  138 ++++++++
>  3 files changed, 1091 insertions(+), 8 deletions(-)
>  create mode 100644 test/sap-client
>  create mode 100755 test/test-sap-server

Pushed upstream. Thanks.

Johan
