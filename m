Return-Path: <ademar@conectiva.com.br>
Message-ID: <40E03705.5040403@conectiva.com.br>
Date: Mon, 28 Jun 2004 11:19:33 -0400
From: "Ademar de Souza Reis Jr." <ademar@conectiva.com.br>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
References: <003401c45c2b$b6eab240$0364a8c0@haruo>	 <20040627125235.GA15938@gmx.net>  <40E02D93.8090305@conectiva.com.br> <1088434128.4614.27.camel@pegasus>
In-Reply-To: <1088434128.4614.27.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Ademar,
> 
> 
>>While we're at this topic: Is there a way to get a license to use the bluez 
>>code in a comercial, closed-source, product? (I was thinking about something 
>>like what QT/Trolltech does).
> 
> 
> the kernel part of BlueZ is GPL and will stay as GPL forever. Another
> license makes no sense here.

Yes, sure.

> 
> For the BlueZ library and the utilities we can talk about it. Some time
> ago people asked for a LGPL version of the library and actually I tend
> to agree with that. However this can't be decided by me alone, because
> part of the code is copyright by Qualcomm and also by Maxim Krasnyansky
> himself.

That would be something really interesting to hear about and I guess it's 
important to define as soon as possible (to avoid including more people with 
copyright code in the ring, for example).

There are already companies interested in creating products with BT support 
under Linux and bluez could be the definitive answer.

 > For the utilities I don't see any need for a different license.
> 
> I believe in the GPL and from my view releasing the Linux Bluetooth
> library under LGPL is the only step I wanna make forward to allow closed
> source products based on BlueZ.

Totally agreed. The only scenario I don't want is the one where the code is 
GPL only and there's no way to license its use in comercial/closed products, 
because that would force companies to use non-standard bluetooth stacks 
under Linux or to avoid using Linux at all...

Thanks.

-- 
Ademar de Souza Reis Jr. <ademar@conectiva.com.br>
Conectiva S.A. - http://www.conectiva.com.br

^[:wq!
