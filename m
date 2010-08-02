Return-Path: <cyrus@holtmann.org>
Message-ID: <4C56B430.4040901@csr.com>
Date: Mon, 02 Aug 2010 13:04:00 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Inga Stotland <ingas@codeaurora.org>
CC: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
        johan.hedberg@gmail.com, marcel@holtmann.org
Subject: Re: Enhancements to allow l2cap channel to use either AMP or BR/EDR
References: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Inga Stotland wrote:
> AMP vs BR/EDR preference for L2CAP channel can be configured as 
> command line argument using new option "-J". Possible values: 
>                  "require_br_edr", 
>                  "prefer_amp", 
>                  "prefer_br_edr"
> If no preference indicated, the default is set to require BR/EDR. 

I think an explicit channel move command and a channel move complete
event are what many applications/profiles will need to be able to use an
AMP effectively.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
