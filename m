Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Mar 2011 15:02:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 4/4] Sim Access Profile test scripts
Message-ID: <20110323130239.GB20755@jh-x301>
References: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300277421-8053-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300277421-8053-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Mar 16, 2011, Waldemar Rymarkiewicz wrote:
> Add simple SAP client python implementation and a test script.
> 
> To run test-sap.py you need Python 2.6 or newer (tested with 2.6 only)
> and PyBluez package installed.
> ---
>  test/sap.py      |  944 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  test/test-sap.py |  139 ++++++++
>  2 files changed, 1083 insertions(+), 0 deletions(-)
>  create mode 100644 test/sap.py
>  create mode 100755 test/test-sap.py

We don't use the .py extension for any other python scripts in the tree
so please don't use it for your scripts either. You'll probably want to
name the scripts a little bit more descriptively than "sap" and
"test-sap". Also remember to mention them to Makefile.tools so they are
part of "make dist" (i.e. add them to EXTRA_DIST).

Johan
