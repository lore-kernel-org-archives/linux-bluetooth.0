Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Mar 2009 21:02:36 +0000
From: James Le Cuirot <chewi@aura-online.co.uk>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bnep should not depend on IPv6
Message-ID: <20090308210236.2eafb651@symphony>
In-Reply-To: <20090308183155.2d68c6e4@symphony>
References: <20090308183155.2d68c6e4@symphony>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 8 Mar 2009 18:31:55 +0000
James Le Cuirot <chewi@aura-online.co.uk> wrote:

> I looked at the source and traced this
> back to network/connection.c where there are two calls to socket()
> with AF_INET6 given as an argument.

Sorry, I actually meant network/common.c.
