Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jul 2011 13:00:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Initial Health Thermometer Profile implementation
Message-ID: <20110729100020.GA14964@dell>
References: <1311682554-21241-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311682554-21241-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Jul 26, 2011, Santiago Carot-Nemesio wrote:
> The following patches don't require the previously submitted patches.
> 
> Adds the plugin and device driver for Health Thermometer Profile.
> Not more functionality is added in these patches at the moment,
> they are the starting point for the HTP implementation.
> 
> [PATCH 1/3] Initial support for Health Thermometer Profile (HTP)
> [PATCH 2/3] Add manager files for HTP
> [PATCH 3/3] Add thermometer driver skeleton
> 
>  Makefile.am               |    7 ++++
>  acinclude.m4              |    6 ++++
>  bootstrap-configure       |    1 +
>  thermometer/main.c        |   62 ++++++++++++++++++++++++++++++++++++++
>  thermometer/manager.c     |   72 +++++++++++++++++++++++++++++++++++++++++++++
>  thermometer/manager.h     |   27 +++++++++++++++++
>  thermometer/thermometer.c |   41 +++++++++++++++++++++++++
>  thermometer/thermometer.h |   27 +++++++++++++++++
>  8 files changed, 243 insertions(+), 0 deletions(-)

These three patches have been applied. However, I went ahead and pushed
another patch on top of them which removes the per-file author info from
thermometer/* and health/*. This information isn't present anywhere else
in the source tree, it becomes a pain to maintain in the long run, and
it's already covered by the AUTHORS file and the git commit history (you
can use e.g. git blame to see who has been working on a specific file).

Johan
