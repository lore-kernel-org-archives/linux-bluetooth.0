Return-Path: <cyrus@holtmann.org>
Subject: Re: rfcomm exit code patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesse Long <jpl@unknown.za.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49626427.1020501@unknown.za.net>
References: <49626427.1020501@unknown.za.net>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 03:38:29 +0100
Message-Id: <1231209509.13304.10.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesse,

> rfcomm does not always indicate failure in it's exit codes, which is a 
> problem when automating things.
> 
> Please consider this patch.

your patch is full of whitespaces/tabs coding style violations. Please
fix them first.

Also error return values should be negative.

Regards

Marcel


