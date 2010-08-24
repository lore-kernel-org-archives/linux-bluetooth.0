Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Aug 2010 11:44:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 0/3] Parsing of AMP related HCI commands and events
Message-ID: <20100824084442.GA28463@jh-x301>
References: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282174734-1314-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Wed, Aug 18, 2010, Inga Stotland wrote:
> Added support for interpreting of the following HCI commands:
> 
> Create Physical Link,
> Accept Physical Link,
> Disconnect Physical Link,
> Create Logical Link,
> Accept Logical Link,
> Disconnect Logical Link,
> Logical Link Cancel,
> Flow Spec Modify,
> Read Encryption Key Size,
> Read Local AMP Info,
> Read Local AMP ASSOC,
> Write Remote AMP ASSOC
> 
> and HCI events:
> 
> Physical Link Complete,
> Disconnect Physical Link Complete,
> Physical Link Loss Early Warning,
> Physical Link Recovery,
> Logical Link Complete,
> Disconnect Logical Link Complete,
> Flow Spec Modify Complete

Thanks. All three patches have been pushed upstream.

Johan
