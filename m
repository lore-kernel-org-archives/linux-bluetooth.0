Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 12:24:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 2/2 v2] Add SetFolder function for MAP tracker
 backend
Message-ID: <20110726092418.GA28891@dell>
References: <20110714140834.GH2770@dell.ger.corp.intel.com>
 <1310732986-7695-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1310732986-7695-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Fri, Jul 15, 2011, Bartosz Szatkowski wrote:
> ---
>  plugins/messages-tracker.c |  170 +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 168 insertions(+), 2 deletions(-)

This doesn't compile:

plugins/messages.c: In function ‘messages_set_folder’:
plugins/messages.c:82:2: error: ‘last’ may be used uninitialized in this function [-Werror=uninitialized]
plugins/messages.c:50:10: note: ‘last’ was declared here

Additionally, please use match_found and not match_find as a variable
name.

Johan
