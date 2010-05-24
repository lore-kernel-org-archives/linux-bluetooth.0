Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 May 2010 10:53:44 +0200
From: Christian Birchinger <joker@netswarm.net>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Auto trust entry remove
Message-ID: <20100524085344.GA18433@netswarm.net>
References: <20100524083330.GA18128@netswarm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100524083330.GA18128@netswarm.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ok, i copied over the "spd" and "profiles" entries from
the previous installation. Now it no longer removes the
trust after a reconnect. It's just stuck in a reconnect
loop (about 10 times) and then the controller gives up
and powers down.
