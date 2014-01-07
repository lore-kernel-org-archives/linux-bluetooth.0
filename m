Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jan 2014 20:28:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/5] tools/rfcomm-tester: Add basic rfcomm test case
Message-ID: <20140107182811.GB18725@x220.p-661hnu-f1>
References: <1389092354-32544-1-git-send-email-marcin.kraglak@tieto.com>
 <1389092354-32544-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389092354-32544-2-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Tue, Jan 07, 2014, Marcin Kraglak wrote:
> +#define test_rfcomm_bredr(name, data, setup, func) \

Since RFCOMM is anyway BR/EDR-only it seems a bit redundant to have
_bredr at the end here. I'd just call this test_rfcomm.

Johan
