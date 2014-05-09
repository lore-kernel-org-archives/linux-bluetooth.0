Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140508074027.GB14385@t440s.lan>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
	<1399351563-25991-2-git-send-email-armansito@chromium.org>
	<20140508074027.GB14385@t440s.lan>
Date: Thu, 8 May 2014 18:46:55 -0700
Message-ID: <CAHrH25TROiskqm-_b9b4oL9dGQDLxiR_XYKqFA5kOnuHeoVS9w@mail.gmail.com>
Subject: Re: [PATCH 01/10] src/shared/att: Introduce struct bt_att.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> + *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
>
> It's ok to have this if you've copied code from elsewhere where there
> was Intel copyright, however probably a lot of the code is by you in
> which case I suppose you'll want to have Google's copyright here. Same
> goes for the other files you're adding.

Thanks for pointing that out, I changed the copyright line to read:

      Copyright (C) 2014  Google Inc.

I will include this as part of v1.
