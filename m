Return-Path: <cyrus@holtmann.org>
Message-ID: <807937.34864.qm@web112809.mail.gq1.yahoo.com>
References: <418098.94079.qm@web112804.mail.gq1.yahoo.com> <1253864301.981724.225.nullmailer@galant.ukfsn.org>
Date: Fri, 25 Sep 2009 02:34:53 -0700 (PDT)
From: Nick Davies <nickavies@yahoo.com>
Subject: Re: Volume control for headset
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1253864301.981724.225.nullmailer@galant.ukfsn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Iain,

  Thanks for your quick response! :)

> Yes, it uses a straight serial (over RFCOMM) link with commands/responses
> being sent each way in plaintext. eg from Audio Gateway (computer) to
> Headset:
> 
> +VGS=n
> 
> set headset speaker volume (0-15)
> 
> +VGM=n
> 
> set headset microphone gain (0-15)
  
  OK, but I don't know where the RFCOMM socket is created, how can I connect to existing socket? 

Best regards,
Nick



      

