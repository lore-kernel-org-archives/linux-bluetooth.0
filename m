Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AE995F.7030107@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] About rfcomm socket
References: <41AD2B86.6010002@avantwave.com>	 <1101882506.18840.18.camel@pegasus>  <41AD867D.2060609@avantwave.com> <1101894514.18840.50.camel@pegasus>
In-Reply-To: <1101894514.18840.50.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 02 Dec 2004 12:26:07 +0800

Dear Marcel
    Thanks for helping. and sorry for disturbing two mailing list.
    Here are the codes generate problems.(i omitted some codes because 
of the size)

My english is no good, I try to make it clear.
There are 3 device, Target device, computer A, computer B. Target device 
is running the code below i.e. connect to computer A through channel 3 
and listen at channel 2. It supposed that computer B can connect to 
target device when target device is connecting others, but it fails. And 
when target stop connecting computer A, computer B can then connect to 
target with channel 2!



int main(void)
{
    if ((connect_pid=fork())==0)
    {
        DEBPRINT("Connect process %d\n",getpid());
        printf("Start connecting...\n");
        do_connect(&stateData);
        return 0;
    }
    else
    {
        DEBPRINT("RTSP listen process %d\n",getpid());
        // waiting phone to connect
        printf("Start listening...\n");
        do_listen(&stateData);
    }
}
int do_connect(TPVSerial_State_t *stateData)
{
    struct sockaddr_rc sa;
    int sk,retry;


    // Create RFCOMM socket
    sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
    if(sk < 0)
    {
        syslog(LOG_ERR, "Cannot create RFCOMM socket. %s(%d)",
                strerror(errno), errno);
        return -1;
    }
   
    sa.rc_family  = AF_BLUETOOTH;
    sa.rc_channel = 3;
    str2ba("00:e0:07:cb:15:68",&sa.rc_bdaddr);

    retry = 3;   
    while(retry--)
    {
        int ret, alen = sizeof(sa);
        DEBPRINT("Conecting...\n");
        ret = connect(sk, (struct sockaddr *) &sa, alen);
        if(ret<0)
        {
            syslog(LOG_ERR, "Connect failed. %s(%d)", strerror(errno), 
errno);
            continue;
        }
        DEBPRINT("Connected\n");

        ba2str(&sa.rc_bdaddr, ba);
   
        syslog(LOG_INFO, "New connection from %s", ba);
        // to handle the SPP connection
        sp_open_connection(sk, stateData);
        close(sk);
    }

    return 0;
}


int do_listen(TPVSerial_State_t *stateData)
{
    struct sockaddr_rc sa;
    int sk;
    fd_set netfd;

    /* setup RFCOMM channel */
    if (!channel)
        channel = SP_DEFAULT_CHANNEL;

    /* add SPP to local SDP server */
    if (use_sdp)
        sp_sdp_register(channel);

    // Create RFCOMM socket
    sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    if(sk < 0)
    {
        syslog(LOG_ERR, "Cannot create RFCOMM socket. %s(%d)",
                strerror(errno), errno);
        return -1;
    }
    //NONBLOCK socket
    flags = fcntl(sk,F_GETFL,0);
    fcntl(sk,F_SETFL,O_NONBLOCK|flags);
   
    sa.rc_family  = AF_BLUETOOTH;
    sa.rc_channel = channel;
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
            if(nsk<0)
            {
                syslog(LOG_ERR, "Accept failed. %s(%d)", 
strerror(errno), errno);
                continue;
            }
            DEBPRINT("Accepted\n");
   
            ba2str(&sa.rc_bdaddr, ba);
   
            syslog(LOG_INFO, "New connection from %s", ba);

            // to handle the SPP connection
            sp_open_connection(nsk, stateData);
            close(nsk);
        }
    }

    if(use_sdp)
        sp_sdp_unregister();
    return 0;
}

Best regard
Mike,Lee

Marcel Holtmann wrote:

>Hi Mike,
>
>you posted your request to both mailing lists. Don't do any cross
>posting.
>
>  
>
>>    Here is code fragment. I use usual fork practise to run these two 
>>func do_connect and do_listen.  I hard code the bluetooth device to be 
>>connected just because code is under testing.
>>    And these two func are using different channel, it can be connected 
>>when do_connect retry more than 3 times.
>>    So i do not why it can not be connected when it is trying to connect 
>>another device.
>>    
>>
>
>I don't get your point. Make it clear who is connecting to whom.
>
>And if you don't set your socket to non-blocking the use of select makes
>no sense. Show us the full code.
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
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
