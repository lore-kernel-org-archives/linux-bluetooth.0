Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Oct 2012 14:12:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] hog: Fix selecting suspend backend
Message-ID: <20121030121248.GA16063@x220.ger.corp.intel.com>
References: <1351263933-21676-1-git-send-email-jprvita@openbossa.org>
 <1351542837-2635-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1351542837-2635-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Mon, Oct 29, 2012, João Paulo Rechi Vita wrote:
> The dummy backend was always being compiled and the --with-hog-suspend
> option was not being accepted by configure. Now the backend can be
> selected with --with-hog-suspend and the suspend implementation file is
> generated during compile time.
> ---
>  .gitignore   | 1 +
>  Makefile.am  | 5 ++++-
>  acinclude.m4 | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
