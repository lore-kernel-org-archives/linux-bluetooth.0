Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <49995A47.8070401@csr.com>
References: <1234727246-21064-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1234727246-21064-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1234727246-21064-3-git-send-email-gustavo@las.ic.unicamp.br>
	 <49995A47.8070401@csr.com>
Date: Mon, 16 Feb 2009 09:37:46 -0300
Message-ID: <6b53b1990902160437q627d2222r590fc2c82fa249aa@mail.gmail.com>
Subject: Re: [PATCH 3/6] Change fprintf(stderr,...) to perror()
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 16, 2009 at 9:21 AM, David Vrabel <david.vrabel@csr.com> wrote:
> Gustavo F. Padovan wrote:
>>
>> @@ -1922,7 +1922,7 @@ static void cmd_lst(int dev_id, int argc, char **argv)
>>       if (dev_id < 0) {
>>               dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);
>>               if (dev_id < 0) {
>> -                     fprintf(stderr, "Not connected.\n");
>> +                     perror("Not connected.");
>>                       exit(1);
>>               }
>>       }
>
> You should only perror() if errno is valid for the error being reported.
>  Otherwise you're going to get odd messages like:
>
> Not connected.: Success

Ok. You are right.

>
> David
> --
> David Vrabel, Senior Software Engineer, Drivers
> CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
> Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/
>



-- 
Gustavo F. Padovan

Computer Engineering Student
Institute of Computing - IC
University of Campinas - UNICAMP

email: gustavo@las.ic.unicamp.br
gtalk: gfpadovan@gmail.com
mobile: +55 19 81030803
