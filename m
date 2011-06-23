Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add adaptername plugin
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 23 Jun 2011 14:44:05 +0100
In-Reply-To: <1308836553-12460-1-git-send-email-hadess@hadess.net>
References: <1308742198-6024-3-git-send-email-hadess@hadess.net>
	 <1308836553-12460-1-git-send-email-hadess@hadess.net>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1308836645.6042.102.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2011-06-23 at 14:42 +0100, Bastien Nocera wrote:
> Replacing the name setting code in src/adapter.c.

This new patch corrects the copyright of the plugin, and makes inotify
look for a few more events (so that you can test the code my
renaming /etc/machine-info to a .bak or something).

