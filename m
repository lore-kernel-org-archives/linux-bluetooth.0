Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <30761901.1248770182239.JavaMail.root@safetgram>
References: <1346165.1248430092866.JavaMail.root@safetgram>
	 <5111969.1248454126654.JavaMail.root@safetgram>
	 <30761901.1248770182239.JavaMail.root@safetgram>
Date: Tue, 28 Jul 2009 11:31:51 -0600
Message-ID: <d89ddf300907281031q67b93549vdd4f62c8a79e9c01@mail.gmail.com>
Subject: Re: Intermittent "Address already in use" error
From: Brad Midgley <bmidgley@gmail.com>
To: John Freeman <johnf@optimation.com.au>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

John

> Once it gets into this state, all further attempts to bind fail with
> "Address already in use" ... until I reboot.

if you're using kernel modules, you might be able to unload/reload a
bluetooth related kernel module to restore it. This would also help
narrowing down the cause.

-- 
Brad Midgley
