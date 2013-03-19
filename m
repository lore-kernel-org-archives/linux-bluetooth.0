Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Mar 2013 15:48:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/4] Basic mgmt API tests for discovery procedure
Message-ID: <20130319134800.GA28886@x220.ger.corp.intel.com>
References: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363639986-16231-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Mon, Mar 18, 2013, Bruna Moreira wrote:
> This series implements initial basic tests for discovery procedure. The
> following tests were added in mgmt-tester utility:
> - Start Discovery: success testcase.
> - Stop discovery: success, rejected and invalid parameters testcases.
> 
> More complex tests (including stop discovery at specific discovery stages) will
> be sent in next weeks.
> 
> BR,
> Bruna Moreira.
> 
> Bruna Moreira (4):
>   tools: Add basic success test for start discovery
>   tools: Add basic success test for stop discovery
>   tools: Add basic rejected test for stop discovery
>   tools: Add basic invalid parameters test for stop discovery
> 
>  tools/mgmt-tester.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)

All patches in this set have been applied. Thanks.

While you're working on new test cases as well as improving the existing
ones please remember that you also can (and should) test for specific
HCI commands caused by the tests.

Johan
