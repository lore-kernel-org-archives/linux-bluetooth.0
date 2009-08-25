Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2009 18:15:15 +0100 (BST)
To: Mateus Interciso <mateus@ouvi.com.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Question on simple RFCOMM server
In-Reply-To: <4A93F2C6.4030708@ouvi.com.br>
References: <4A93D887.8060007@ouvi.com.br> <1251207686.259635.1938.nullmailer@galant.ukfsn.org> <4A93F2C6.4030708@ouvi.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1251220515.564598.718.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 25 Aug 2009, Mateus Interciso wrote:

> Or is there any configuration that can make a normal user change the default
> link mode?

yes - do

	int opt = RFCOMM_LM_MASTER;
	setsockopt(listend, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt));

before listen()

iain


