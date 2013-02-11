Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: Re: [PATCH 00/14] neard plugin update
Date: Mon, 11 Feb 2013 10:52:36 +0100
Message-ID: <2589959.gQ4yNVdaLa@uw000953>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

On Thursday 07 of February 2013 10:13:50 Janc Szymon wrote:
> This set adds some new features to neard plugin to match it with
> recent changes in neard daemon:
> - support for carrier power state hint (already merged)
> - update register API [with fallback to legacy support] (pending review)

Just to notify that register API changes were just merged into neard.git so all
code needed is now present in neard daemon.

> 
> Power state hint could be use to improve IOP e.g. delay or retry pairing when
> remote device in activating or incative state.
> 
> Other than that bugfixes, small improvements and some code refactoring to
> make it better prepared for future feature addition e.g. to perform more
> action on PushOOB than only pairing.
> 
> There are still some open points regarding how to properly map adapter
> state (powered/pairable/connectable) to carrier power state but those
> could be discussed separately later on.
> 
> Comments are welcome.
> 
> BR
> Szymon Janc
> 
> Ravi kumar Veeramally (1):
>   neard: Updated neard handover registration agent api calls.
> 
> Szymon Janc (13):
>   neard: Adjust errors to latest API changes
>   neard: Refactor message processing
>   neard: Add ability to parse 'State' field
>   neard: Move pairable check from check_adapter
>   adapter: Add btd_adapter_get_powered function
>   neard: Check if adapter is powered in PushOOB
>   adapter: Add btd_adapter_get_connectable function
>   neard: Add support for setting power state in RequestOOB reply
>   neard: Use path instead of boolean to track if registered to neard
>   neard: Restrict method calls only to neard process
>   neard: Use bool instead of gboolean for agent_register_postpone
>   neard: Update copyright information
>   neard: Add fallback to legacy register if register failed
> 
>  plugins/neard.c | 562 ++++++++++++++++++++++++++++++++++----------------------
>  src/adapter.c   |  16 ++
>  src/adapter.h   |   2 +
>  3 files changed, 361 insertions(+), 219 deletions(-)
> 
> 
