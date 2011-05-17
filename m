Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 May 2011 08:51:06 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Adjust SPARQL queries to the changes in call history
Message-ID: <20110517155106.GA17702@dell.ice.intel.com>
References: <1305017315-30927-1-git-send-email-lkslawek@gmail.com>
 <1305025781-21893-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305025781-21893-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, May 10, 2011, Slawomir Bochenski wrote:
> Currently nmo:Call resources put to the Tracker by commhistory do not use
> the same nco:PhoneNumber as the one bound to the nco:PersonContact. This
> patch introduces matching contacts by actual phone number, thus returning
> proper contact data regardless of this commhistory change.
> ---
> In the previous version backslashes at the ends of lines were incorrectly
> aligned.
>  plugins/phonebook-tracker.c |   74 ++++++++++++++++++++++++++++++------------
>  1 files changed, 53 insertions(+), 21 deletions(-)

Pushed upstream. Thanks.

Johan
