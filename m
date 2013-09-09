Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Sep 2013 18:03:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= DALLEAU
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] sco-tester: Introduce adapter features
Message-ID: <20130909150348.GA4739@x220.p-661hnu-f1>
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1376062977-1497-2-git-send-email-frederic.dalleau@linux.intel.com>
 <20130909083356.GC29399@x220.p-661hnu-f1>
 <522DC4FD.1010601@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <522DC4FD.1010601@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Mon, Sep 09, 2013, Frédéric DALLEAU wrote:
> >First of all, you should use "false" here instead of "0" (and same for
> >true vs 1 later).
> >
> >Secondly, whenever you want to manipulate some parameter of a test case
> >it should not be done in the main function like that but instead you
> >should have it as part of the test case data (struct sco_client_data)
> >and create a separate instance for each test case.
> >
> >I do realize that the initial sco-tester didn't get this right (having
> >disable_sco in struct test_data instead of struct sco_client_data), but
> >it'd be good to get this fixed before adding any new test cases.
> 
> The problem is that the adapter feature has to be defined far before
> the test is started.

The sco_client structs are static ones and therefore available when the
tester starts, so I'm not sure what the issue is.

> Another problem is that sco_client_data is test dependant, eg. each
> test can implement sco_client_data differently. In this case,
> adapter_features could simply be undefined! This is already the case
> in the first tests which do not use struct sco_client_data at all
> (test_socket).
> 
> IMHO We do not want that. adapter_features must be defined explictly
> before each test. This is mandatory.
> 
> In future I'm also thinking to implement some adapter "behavior".
> For example : one test could be : try connect, emulator must accept,
> and expected result is success. then try connect, emulator must
> refuse, and result is expected to be connection refused.
> 
> My suggestion would be really different from yours :
> I would write a big table with the elements of test_sco.
> 
> struct test {
> 	char *name;
> 	struct adapter_features *features;
> 	struct adapter_behavior *behavior; /* If needed */
> 	void (*test_cb)(struct test *test, void *data);
>         void *user_data; /* sco_client_data*/
> 	int expected_result;
> } tests [] = {...};
> 
> while (test[i].name) {
>     test_sco(test[i].name, test[i].test_cb, ...);
>     i++;
> }
> 
> Let me know what you think.

I wasn't trying to suggest something new but just describe what the
other end-to-end testers under tools/ do. Take a look at e.g.
l2cap-tester or mgmt-tester (which has the most extensive list of test
cases). Neither one of those has needed anything similar to what you're
proposing and if we go ahead and adopt a new model for sco-tester then
all the testers should follow it.

If you feel like the adapter properties have to be somewhere "higher up"
than sco_client_data (which they really don't have to be) one option is
to move it to the test_data and simply have separate macros for defining
test cases for different types of controllers, just like mgmt-tester
does with test_bredrle(), test_bredr() and test_le().

Johan
