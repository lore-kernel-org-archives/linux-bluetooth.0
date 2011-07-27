Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Wed, 27 Jul 2011 08:53:41 -0300
Message-ID: <CAJdJm_NAaG6-YKAmk=U5mzhCvC3=aCm=w2pPzDtKfQgJpjwpsA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/5] Add Get/Set Property for Link Loss
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 26, 2011 at 1:53 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Dependency: "[PATCH] Proximity Monitor implementation (for testing)"
> sent from Anderson Lizardo. Small conflict in proximity/manager.c

Actually, my series was for Proximity Reporter. But the conflict note
still holds.  proximity/manager.c has entry points for both Monitor
and Reporter, thus the dependency.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
