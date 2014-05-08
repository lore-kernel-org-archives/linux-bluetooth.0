Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 May 2014 10:40:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/10] src/shared/att: Introduce struct bt_att.
Message-ID: <20140508074027.GB14385@t440s.lan>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
 <1399351563-25991-2-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399351563-25991-2-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, May 05, 2014, Arman Uguray wrote:
> + *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.

It's ok to have this if you've copied code from elsewhere where there
was Intel copyright, however probably a lot of the code is by you in
which case I suppose you'll want to have Google's copyright here. Same
goes for the other files you're adding.

Johan
