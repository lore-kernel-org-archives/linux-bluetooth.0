Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 16:28:50 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] use a valid PSM value in l2test.
Message-ID: <20110209182850.GG1995@joana>
References: <1297275997-15274-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297275997-15274-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2011-02-09 16:26:37 -0200]:

> ---
>  test/l2test.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Gah, this is wrong. L2CAP doesn't accept this value


-- 
Gustavo F. Padovan
http://profusion.mobi
