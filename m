Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41AD867D.2060609@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: [Bluez-devel] About rfcomm socket
References: <41AD2B86.6010002@avantwave.com> <1101882506.18840.18.camel@pegasus>
In-Reply-To: <1101882506.18840.18.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 01 Dec 2004 16:53:17 +0800

Dear Marcel
    Thanks for helping.
    Here is code fragment. I use usual fork practise to run these two 
func do_connect and do_listen.  I hard code the bluetooth device to be 
connected just because code is under testing.
    And these two func are using different channel, it can be connected 
when do_connect retry more than 3 times.
    So i do not why it can not be connected when it is trying to connect 
another device.


int *do_connect*(TPVSerial_State_t *stateData)
{
    struct sockaddr_rc sa;
    int sk,retry;
    // Create RFCOMM socket
    sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
   
    sa.rc_family  = AF_BLUETOOTH;
    sa.rc_channel = 3;
    str2ba("00:e0:07:cb:15:68",&sa.rc_bdaddr);

    retry = 3;   
    while(retry--)
    {
        int ret, alen = sizeof(sa);
        DEBPRINT("Conecting...\n");
        ret = connect(sk, (struct sockaddr *) &sa, alen);
        DEBPRINT("Connected\n");
        ba2str(&sa.rc_bdaddr, ba);
        syslog(LOG_INFO, "New connection from %s", ba);
        // to handle the SPP connection
        sp_open_connection(sk, stateData);
        close(sk);
    }
    return 0;
}

int *do_listen*(TPVSerial_State_t *stateData)
{
    struct sockaddr_rc sa;
    int sk;
    fd_set netfd;


    // Create RFCOMM socket
    sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
   
    sa.rc_family  = AF_BLUETOOTH;
    sa.rc_channel = 2
    sa.rc_bdaddr  = src_addr;

    if (bind(sk, (struct sockaddr *) &sa, sizeof(sa)))
    {
        syslog(LOG_ERR, "Bind failed. %s(%d)", strerror(errno), errno);
        return -1;
    }
    listen(sk, 10);
    FD_ZERO(&netfd);
    terminate = 0;
    while(!terminate)
    {
        int  alen = sizeof(sa), nsk;
         FD_SET(sk,&netfd);
        syslog(LOG_INFO, "Waiting for connection...");
        DEBPRINT("wait Accept\n");
        select(sk+1,&netfd,NULL,NULL,NULL)

        if(FD_ISSET(sk,&netfd)){       
            nsk = accept(sk, (struct sockaddr *) &sa, &alen);
            DEBPRINT("Accepted\n");
   
            ba2str(&sa.rc_bdaddr, ba);
            syslog(LOG_INFO, "New connection from %s", ba);

            // to handle the SPP connection
            sp_open_connection(nsk, stateData);
            close(nsk);
        }
    }
    return 0;
}


Marcel Holtmann wrote:

>Hi Mike,
>
>  
>
>>    I have tried to fork two process, One use socket system call - 
>>accept at rfcomm channel 2, and another try to connect to a bluetooth 
>>device thought channel 3. But i found that i can not use a 3rd device to 
>>connect to the listen channel 2 at the same time.
>>    
>>
>
>show us the source code for that.
>
>  
>
>>    I am using bluez-lib-2.6, utils-2.6. ,hci-uart and linux-2.4.18 
>>patched with patch-2.4.18-mh15.
>>    
>>
>
>The bluez-libs and bluez-utils are at version 2.11 and you should update
>both of them.
>
>  
>
>>    My question is simple, Could bluez be multi-tasking?
>>    
>>
>
>You may not be able to do some crazy things, but in general yes.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>  
>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
