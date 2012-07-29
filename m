Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Jul 2012 21:13:21 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 4/7] Bluetooth: Refactor ACL connection into its own
 function
Message-ID: <20120729001321.GB16534@echo>
References: <1343428380-32705-1-git-send-email-vinicius.gomes@openbossa.org>
 <1343428380-32705-5-git-send-email-vinicius.gomes@openbossa.org>
 <CAJdJm_MJM3AKu6Rrir+WkwyeyoEezjjvqQY2E14bzcUSz2NcXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_MJM3AKu6Rrir+WkwyeyoEezjjvqQY2E14bzcUSz2NcXw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On 18:52 Fri 27 Jul, Anderson Lizardo wrote:
> Hi Vinicius,
> 
> On Fri, Jul 27, 2012 at 6:32 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > The hci_connect() function was starting to get too complicated to be
> > quickly understood. We can separated the creation of a new ACL
> 
> small typo: separated -> separate

Ugh. Thanks.


Cheers,
-- 
Vinicius
