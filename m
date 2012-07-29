Return-Path: <cyrus@holtmann.org>
Message-ID: <1343579514.1803.49.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/2] tools: Fix workaround to build with recent
 flex
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 29 Jul 2012 09:31:54 -0700
In-Reply-To: <1343543435-8429-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1343543435-8429-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> Flex 2.5.36 no longer defines isatty(), resulting in the following build
> error:
> 
> 	tools/lexer.c:1402:9: error: implicit declaration of function
> 	‘isatty’ [-Werror=implicit-function-declaration]
> 
> Include the header unistd.h so we get the definition of that function
> and at the same time keep the fix for older versions of flex, since this
> header defines _UNISTD_H.

lets remove the rfcomm.conf support from rfcomm utility and then move it
under tools/. So no more need for flex or bison.

Regards

Marcel


