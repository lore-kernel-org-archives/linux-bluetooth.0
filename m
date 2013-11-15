Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384451935-4836-1-git-send-email-a.heider@gmail.com>
References: <1384451935-4836-1-git-send-email-a.heider@gmail.com>
Date: Fri, 15 Nov 2013 10:37:53 +0100
Message-ID: <CAHsu+b9nHbrXt6rF5VahmXeoTEMwBgf-C3vOJQOQ3meDnpCQyA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix out of tree builds
From: Andre Heider <a.heider@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 14, 2013 at 6:58 PM, Andre Heider <a.heider@gmail.com> wrote:
> Don't create bogus symlinks when passing an absolute path to --prefix.

No idea how that happened, but I meant:
Don't create bogus symlinks when calling the configure script via an
absolute path.

;)

Regards,
Andre
