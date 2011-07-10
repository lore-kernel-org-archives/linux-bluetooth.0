Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Jul 2011 10:49:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, radoslawjablonski@gmail.com
Subject: Re: [PATCH obexd v2] Fix invalid memory read when pulling phone book
Message-ID: <20110710074958.GA1808@dell.ger.corp.intel.com>
References: <1310040100-31241-1-git-send-email-dmitriy.paliy@nokia.com>
 <1310040100-31241-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310040100-31241-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Jul 07, 2011, Dmitriy Paliy wrote:
> Data contacts are freed ones in finalize function which is called in
> query_result callback function. Calling free_data_contacts(data) twice
> for last phone book part causes invalid memory read when dereferencing
> data->contacts.
> ---
>  plugins/phonebook-tracker.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
