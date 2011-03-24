Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Thu, 24 Mar 2011 11:40:33 +0200
Subject: RE: [PATCH v5 4/4] Sim Access Profile test scripts
Message-ID: <99B09243E1A5DA4898CDD8B7001114481085D15573@EXMB04.eu.tieto.com>
References: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300277421-8053-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110323130239.GB20755@jh-x301>
In-Reply-To: <20110323130239.GB20755@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, 

>We don't use the .py extension for any other python scripts in 
>the tree so please don't use it for your scripts either. 
>You'll probably want to name the scripts a little bit more 
>descriptively than "sap" and "test-sap". Also remember to 
>mention them to Makefile.tools so they are part of "make dist" 
>(i.e. add them to EXTRA_DIST).
>

In fact, I missed EXTRA_DIST. Will fix this then.
I will remove .py extensions as well. I understand that the dbusdef.py is an exception?

I could propose test/sap-client and  test/test-sap or test/test-sap-server . It seems more saner I think. Doesn't it?

Waldek
